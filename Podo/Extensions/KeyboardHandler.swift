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

    func nextIndex(_ currentIndex: Int) -> Int {
        switch self {
        case .backward: return currentIndex - 1
        case .forward: return currentIndex + 1
        }
    }
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
        let offset = parsed.offset * offsetRatio

        // Handle not-scrollable views
        guard let textInput = UIResponder.current as? UIView else { return }

        for view in nonScrollableViews {
            let textInputFrame = textInput.normalizedFrame
            let visibleRect = CGRect(x: UIScreen.main.bounds.origin.x,
                                     y: UIScreen.main.bounds.origin.y,
                                     width: UIScreen.main.bounds.width,
                                     height: UIScreen.main.bounds.height - parsed.endFrame.height)
            let nonScrollableOffset = textInputFrame.minY - visibleRect.midY

            initialNonScrollableViewsOffsets[view] = view.frame.origin.y

            UIView.animate(withDuration: parsed.duration, delay: 0, options: parsed.options, animations: {
                if nonScrollableOffset < 0 {
                    // move view down
                    view.frame.origin.y -= max(nonScrollableOffset, view.frame.maxY - UIScreen.main.bounds.maxY)
                } else {
                    // move view up
                    if view.frame.maxY - nonScrollableOffset - visibleRect.maxY > 0 {
                        view.frame.origin.y -= nonScrollableOffset
                    } else {
                        view.frame.origin.y -= (view.frame.maxY - visibleRect.maxY)
                    }
                }
            })
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
            guard let initialOffset = initialNonScrollableViewsOffsets[view] else { continue }

            UIView.animate(withDuration: parsed.duration, delay: 0, options: parsed.options, animations: {
                view.frame.origin.y = initialOffset
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

    private func switchToTextResponder(direction: Direction) {
        guard let manageableViews = delegate?.manageableViews else { return }

        for view in manageableViews {
            var responders = view.responders.compactMap { $0 as? UIView }

            responders.sort { resp1, resp2 in
                if resp1.normalizedFrame.withinHorizontalBaselines(of: resp2.normalizedFrame) {
                    return resp1.normalizedFrame.leftRelative(to: resp2.normalizedFrame)
                }
                return resp1.normalizedFrame.aboveRelative(to: resp2.normalizedFrame)
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
