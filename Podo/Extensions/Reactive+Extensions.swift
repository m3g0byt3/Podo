//
//  Reactive+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 28/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {

    /**
     Reactive wrapper for target action pattern on `self.leftView` as `UIButton`
     */
    var leftOverlayButtonTap: ControlEvent<Void>? {
        return base.leftView.flatMap { $0 as? UIButton }?.rx.tap
    }

    /**
     Reactive wrapper for target action pattern on `self.rightView` as `UIButton`
     */
    var rightOverlayButtonTap: ControlEvent<Void>? {
        return base.rightView.flatMap { $0 as? UIButton }?.rx.tap
    }

    /// Bindable sink for `placeholder` property.
    public var placeholder: Binder<String?> {
        return Binder(self.base) { textField, value in
            textField.placeholder = value
        }
    }
}

extension Reactive where Base: GradientView {

    /// Bindable sink for `gradientColors` property.
    var gradientColors: Binder<[UIColor]> {
        return Binder(self.base) { view, value in
            view.gradientColors = value
        }
    }
}

extension Reactive where Base: LabeledTextField {

    /// Bindable sink for `textFieldPlaceholder` property.
    var placeholder: Binder<String?> {
        return Binder(self.base) { labeledTextField, value in
            labeledTextField.textFieldPlaceholder = value
        }
    }

    /// Bindable sink for `labelText` property.
    var labelText: Binder<String?> {
        return Binder(self.base) { labeledTextField, value in
            labeledTextField.labelText = value
        }
    }

    /// Reactive wrapper for `textFieldText` property.
    var textFieldText: ControlProperty<String?> {
        return base.rx.controlProperty(
            editingEvents: .allEditingEvents,
            getter: { labeledTextField in
                labeledTextField.textFieldText
            },
            setter: { labeledTextField, value in
                // This check is important because setting text value always clears control state
                // including marked text selection which is imporant for proper input
                // when IME input method is used.
                if labeledTextField.textFieldText != value {
                    labeledTextField.textFieldText = value
                }
            }
        )
    }

    /// Reactive wrapper for `TouchUpInside` control event.
    var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
