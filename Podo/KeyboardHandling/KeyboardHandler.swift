//
//  KeyboardHandler.swift
//  Podo
//
//  Created by m3g0byt3 on 11/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class KeyboardHandler {

    // MARK: - Private helpers types

    /// Represent direction of next responder switching.
    private enum Direction {

        case forward, backward

        func nextIndex(_ currentIndex: Int) -> Int {
            switch self {
            case .backward: return currentIndex - 1
            case .forward: return currentIndex + 1
            }
        }
    }

    /// Represents type of action for keyboard.
    private enum KeyboardAction {

        case show, hide
    }

    // MARK: - Constants

    /// Notification names.
    private enum Names {

        static var willShow: Notification.Name { return .UIKeyboardWillShow }
        static var willHide: Notification.Name { return .UIKeyboardWillHide }
    }

    /// Various selectors.
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
        this.isTranslucent = false
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

    private var initialNonScrollableViewsOffsets: EphemeralDictionaryWrapper<UIView, CGFloat>

    // MARK: - Lifecycle

    init(delegate: KeyboardHandling) {
        self.delegate = delegate
        self.initialNonScrollableViewsOffsets = [:]
        delegate.manageableViews.forEach(setupInputAccessoryView(in:))
        registerForNotifications(in: NotificationCenter.default)
    }

    deinit {
        unregisterForNotifications(in: NotificationCenter.default)
    }

    // MARK: - Private API

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

        // Handle non-scrollable views
        nonScrollableViews.forEach { handleNonScrollableView($0, info: parsed, action: .show) }

        // Handle scrollable views
        scrollableViews.forEach { handleScrollableView($0, info: parsed, action: .show) }
    }

    @objc private func keyboardDismissed(_ notification: Notification) {
        guard let parsed = KeyboardNotification(notification) else { return }

        // Handle non-scrollable views
        nonScrollableViews.forEach { handleNonScrollableView($0, info: parsed, action: .hide) }

        // Handle scrollable views
        scrollableViews.forEach { handleScrollableView($0, info: parsed, action: .hide) }
    }

    private func handleNonScrollableView(_ view: UIView, info: KeyboardNotification, action: KeyboardAction) {
        switch action {

        case .show:
            guard let currentResponder = UIResponder.current as? UIView else { return }
            let currentResponderConvertedBounds = currentResponder.normalizedBounds
            let nonScrollableOffset = yAxisOffset(for: currentResponderConvertedBounds, basedOn: info)
            let maxNonScrollableOffset: CGFloat
            let offsetComparator: (CGFloat, CGFloat) -> CGFloat

            if nonScrollableOffset > 0 {
                // View moves up
                maxNonScrollableOffset = view.frame.maxY - info.endFrame.minY
                offsetComparator = min
            } else {
                // View moves down
                maxNonScrollableOffset = view.frame.maxY - UIScreen.main.bounds.maxY
                offsetComparator = max
            }

            initialNonScrollableViewsOffsets[view] = view.frame.origin.y

            UIView.animate(withDuration: info.duration, delay: 0, options: info.options, animations: {
                view.frame.origin.y -= offsetComparator(nonScrollableOffset, maxNonScrollableOffset)
            })

        case .hide:
            guard let initialOffset = initialNonScrollableViewsOffsets[view] else { break }

            UIView.animate(withDuration: info.duration, delay: 0, options: info.options, animations: {
                view.frame.origin.y = initialOffset
            })
        }
    }

    private func handleScrollableView(_ view: UIScrollView, info: KeyboardNotification, action: KeyboardAction) {
        switch action {

        case .show:
            if info.endFrame != info.beginFrame {
                view.contentInset.bottom += info.offset * offsetRatio
            }

            guard let currentResponder = UIResponder.current as? UIView else { return }
            let currentResponderConvertedBounds = view.convert(currentResponder.frame, from: currentResponder)
            let yAxisContentOffset = yAxisOffset(for: currentResponderConvertedBounds, basedOn: info)
            let contentOffset = CGPoint(x: view.contentOffset.x, y: yAxisContentOffset)

            UIView.animate(withDuration: info.duration, delay: 0, options: info.options, animations: {
                view.contentOffset = contentOffset
            })

            // Redudant, but prevents absent of inputAccessoryView when current First Responder
            // was not visible initially - for example outside of visible area of scrollable view.
            setupInputAccessoryView(in: view)

        case .hide:
            if info.endFrame != info.beginFrame {
                view.contentInset.bottom -= info.offset * offsetRatio
            }
        }
    }

    private func yAxisOffset(for rect: CGRect, basedOn info: KeyboardNotification) -> CGFloat {
        let visibleRect = CGRect(x: UIScreen.main.bounds.origin.x,
                                 y: UIScreen.main.bounds.origin.y,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height - info.endFrame.height)
        return rect.minY - visibleRect.midY
    }

    private func switchToTextResponder(direction: Direction) {
        guard let manageableViews = delegate?.manageableViews else { return }

        for view in manageableViews {
            var responders = view.responders.compactMap { $0 as? UIView }

            responders.sort { resp1, resp2 in
                if resp1.normalizedBounds.withinHorizontalBaselines(of: resp2.normalizedBounds) {
                    return resp1.normalizedBounds.leftRelative(to: resp2.normalizedBounds)
                }
                return resp1.normalizedBounds.aboveRelative(to: resp2.normalizedBounds)
            }

            guard
                let currentResponder = UIResponder.current as? UIView,
                let currentResponderIndex = responders.index(of: currentResponder)
            else { continue }

            let nextResponderIndex = direction.nextIndex(currentResponderIndex)

            guard let nextResponder = responders[safe: nextResponderIndex] else {
                currentResponder.resignFirstResponder()
                continue
            }

            nextResponder.becomeFirstResponder()
        }
    }

    // MARK: - Button handlers

    @objc private func doneButtonHandler(_ sender: UIBarButtonItem) {
        UIApplication.shared.sendAction(Selectors.resign, to: nil, from: nil, for: nil)
    }

    @objc private func backButtonHandler(_ sender: UIBarButtonItem) {
        switchToTextResponder(direction: .backward)
    }

    @objc private func nextButtonHandler(_ sender: UIBarButtonItem) {
        switchToTextResponder(direction: .forward)
    }
}
