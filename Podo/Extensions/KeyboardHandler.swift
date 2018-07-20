//
//  KeyboardHandler.swift
//  Podo
//
//  Created by m3g0byt3 on 11/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

private enum Direction {
    case forward, backward
}

final class KeyboardHandler {

    // MARK: - Constants

    /// Notification names
    private enum Names {

        static var willShow: Notification.Name { return .UIKeyboardWillShow }
        static var willHide: Notification.Name { return .UIKeyboardWillHide }
    }

    /// Various selectors
    private enum Selectors {

        static var shown: Selector { return #selector(keyboardShown(_:)) }
        static var dismissed: Selector { return #selector(keyboardDismissed(_:)) }
        static var done: Selector { return #selector(doneButtonHandler(_:)) }
        static var back: Selector { return #selector(backButtonHandler(_:)) }
        static var next: Selector { return #selector(nextButtonHandler(_:)) }
        static var resign: Selector { return #selector(UIResponder.resignFirstResponder) }
    }

    // MARK: - Public Properties

    weak var delegate: KeyboardHandling?

    // MARK: - Private Properties

    private lazy var customInputView: UIToolbar = { this in
        let backButton = UIBarButtonItem(title: " ◀ ", style: .done, target: self, action: Selectors.back)
        let nextButton = UIBarButtonItem(title: " ▶ ", style: .done, target: self, action: Selectors.next)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selectors.done)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        this.items = [backButton, nextButton, flexibleSpace, doneButton]
        this.items?.forEach { $0.tintColor = .darkGray }
        this.sizeToFit()

        return this
    }(UIToolbar())

    private var scrollableViews: [UIScrollView] {
        return delegate?.manageableViews.compactMap { $0 as? UIScrollView } ?? []
    }

    private var nonScrollableViews: [UIView] {
        return delegate?.manageableViews.filter { !($0 is UIScrollView) } ?? []
    }

    private var offsetRatio: CGFloat {
        return delegate?.keyboardOffsetRatio ?? 1.0
    }

    private var initialOffsets: [UIView: CGFloat]

    // MARK: - Lifecycle

    init(delegate: KeyboardHandling) {
        self.delegate = delegate
        self.initialOffsets = [:]
        setupDelegate(delegate)
        registerForNotifications(in: NotificationCenter.default)
    }

    deinit {
        unregisterForNotifications(in: NotificationCenter.default)
    }

    // MARK: - Private API

    private func setupDelegate(_ delegate: KeyboardHandling) {
        delegate.manageableViews.forEach(setupInputAccessoryView(in:))
    }

    private func setupInputAccessoryView(in view: UIView) {
        if let castedView = view as? _InputAccessoryViewProtocol {
            castedView.inputAccessoryView = customInputView
        } else {
            view.subviews.forEach(setupInputAccessoryView)
        }
    }

    private func registerForNotifications(in center: NotificationCenter) {
        center.addObserver(self, selector: Selectors.shown, name: Names.willShow, object: nil)
        center.addObserver(self, selector: Selectors.dismissed, name: Names.willHide, object: nil)
    }

    private func unregisterForNotifications(in center: NotificationCenter) {
        center.removeObserver(self)
    }

    @objc private func keyboardShown(_ notification: Notification) {
        guard let parsed = KeyboardNotification(notification) else { return }
        let offset = parsed.offset * offsetRatio

        // Handle not-scrollable views
        guard let textInput = UIResponder.current as? UIView else { return }

        for view in nonScrollableViews {
            let textInputConvertedFrame = view.convert(textInput.frame, from: textInput)
            let textInputMaxY = textInputConvertedFrame.maxY
            let visibleHeight = view.frame.height - offset
            let nonScrollableOffset = textInputMaxY - visibleHeight / 2

            initialOffsets[view] = view.frame.origin.y

            if textInputMaxY > visibleHeight {
                UIView.animate(withDuration: parsed.duration, delay: 0, options: parsed.options, animations: {
                    view.frame.origin.y -= min(offset, nonScrollableOffset)
                })
            }
        }

        // Handle scrollable views
        guard parsed.endFrame != parsed.beginFrame else { return }

        for view in scrollableViews {
            view.contentInset.bottom += offset
        }
    }

    @objc private func keyboardDismissed(_ notification: Notification) {
        guard let parsed = KeyboardNotification(notification) else { return }
        let offset = parsed.offset * offsetRatio

        // Handle not-scrollable views
        for view in nonScrollableViews {
            UIView.animate(withDuration: parsed.duration, delay: 0, options: parsed.options, animations: {
                view.frame.origin.y = self.initialOffsets[view, default: 0]
            })
        }

        // Handle scrollable views
        guard parsed.endFrame != parsed.beginFrame else { return }

        for view in scrollableViews {
            view.contentInset.bottom -= offset
        }
    }

    private func centerForInput() {
        // TODO: Calculate offset to place current first reponder in the center of visible rect
    }

    private func switchToNextTextInput(in view: UIView) {
        switchToTextInput(in: view, direction: .forward)
    }

    private func switchToPreviousTextInput(in view: UIView) {
        switchToTextInput(in: view, direction: .backward)
    }

    private func switchToTextInput(in view: UIView, direction: Direction) {
        guard let currentResponder = UIResponder.current as? UIView else { return }
        let horizontalRelativeFunction: (CGRect) -> (CGRect) -> Bool
        let horizontalBaselineFunction: (CGRect) -> (CGRect) -> Bool
        let verticalRelativeFunction: (CGRect) -> (CGRect) -> Bool

        switch direction {
        case .backward:
            horizontalRelativeFunction = CGRect.leftRelative
            horizontalBaselineFunction = CGRect.withinHorizontalBaselines
            verticalRelativeFunction = CGRect.aboveRelative
        case .forward:
            horizontalRelativeFunction = CGRect.rightRelative
            horizontalBaselineFunction = CGRect.withinHorizontalBaselines
            verticalRelativeFunction = CGRect.belowRelative
        }

        let candidateResponders = view.responders
            .compactMap { $0 as? UIView }
            .filter { $0 !== currentResponder }

        let horizontalNextResponder = candidateResponders
            .filter { horizontalRelativeFunction($0.normalizedFrame)(currentResponder.normalizedFrame) }
            .filter { horizontalBaselineFunction($0.normalizedFrame)(currentResponder.normalizedFrame) }
            .min { $0.normalizedFrame.minX < $1.normalizedFrame.minX }

        if horizontalNextResponder != nil {
            horizontalNextResponder?.becomeFirstResponder()
            return
        }

        let verticalNextResponder = candidateResponders
            .filter { verticalRelativeFunction($0.normalizedFrame)(currentResponder.normalizedFrame) }
            .min { $0.normalizedFrame.minY < $1.normalizedFrame.minY }

        if verticalNextResponder != nil {
            verticalNextResponder?.becomeFirstResponder()
            return
        }

        currentResponder.resignFirstResponder()
    }

    // MARK: - Button handlers

    @objc private func doneButtonHandler(_ sender: UIBarButtonItem) {
        UIApplication.shared.sendAction(Selectors.resign, to: nil, from: nil, for: nil)
    }

    @objc private func backButtonHandler(_ sender: UIBarButtonItem) {
        delegate?.manageableViews.forEach(switchToPreviousTextInput(in:))
    }

    @objc private func nextButtonHandler(_ sender: UIBarButtonItem) {
        delegate?.manageableViews.forEach(switchToNextTextInput(in:))
    }
}
