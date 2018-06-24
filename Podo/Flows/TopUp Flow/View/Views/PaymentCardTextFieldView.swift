//
//  PaymentCardTextFieldView.swift
//  Podo
//
//  Created by m3g0byt3 on 24/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
final class PaymentCardTextFieldView: UIView {

    // MARK: - Typealiases

    typealias ButtonHandler = (PaymentCardTextFieldView) -> Void

    // MARK: - Private Properties

    private static var underlineWidth: CGFloat { return 1 / UIScreen.main.scale }
    private weak var textField: ScanCardTextField?
    private weak var label: UILabel?
    private var colorObserver: NSKeyValueObservation?
    private var _underlineColor: UIColor?

    // MARK: - Public Properties

    var buttonHandler: ButtonHandler?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupObservers()
    }

    // MARK: - Public API

    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }

    override func draw(_ rect: CGRect) {
        let startPorint = CGPoint(x: bounds.minX, y: bounds.maxY)
        let endPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)

        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(PaymentCardTextFieldView.underlineWidth)
            underlineColor.map { $0.cgColor }.map { context.setStrokeColor($0) }
            context.move(to: startPorint)
            context.addLine(to: endPoint)
            context.strokePath()
        }
    }

    // MARK: - Private API

    /// Setup required UI.
    private func setupUI() {
        let textField = ScanCardTextField()
        let label = UILabel()

        textField.borderStyle = .none
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.clearButtonMode = .never
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.buttonHandler = { [unowned self] _ in
            self.buttonHandler?(self)
        }
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        [textField, label].forEach(addSubview)
        self.textField = textField
        self.label = label
        isOpaque = false
    }

    /**
     Setup required constraints.
     - warning: ⚠️ Dispatched once ⚠️
     */
    private lazy var setupConstraints: () -> Void = { [weak self] in
        label?.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }

        textField?.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            if let label = label {
                make.top.equalTo(label.snp.bottom)
            }
        }

        return {}
    }()

    /// Setup KVO for `backgroundColor` property.
    private func setupObservers() {
        colorObserver = self.observe(\.backgroundColor, options: [.initial, .new]) { (obj, change) in
            if let color = change.newValue {
                obj.label?.backgroundColor = color
                obj.textField?.backgroundColor = color
            }
        }
    }
}

// MARK: - Public IBInspectable Properties

extension PaymentCardTextFieldView {

    @IBInspectable
    var labelText: String? {
        get { return label?.text }
        set { label?.text = newValue }
    }

    @IBInspectable
    var labelTextColor: UIColor? {
        get { return label?.textColor }
        set { label?.textColor = newValue }
    }

    @IBInspectable
    var textFieldText: String? {
        get { return textField?.text }
        set { textField?.text = newValue }
    }

    @IBInspectable
    var textFieldPlaceholder: String? {
        get { return textField?.placeholder }
        set { textField?.placeholder = newValue }
    }

    @IBInspectable
    var textFieldTextColor: UIColor? {
        get { return textField?.textColor }
        set { textField?.textColor = newValue }
    }

    @IBInspectable
    var underlineColor: UIColor? {
        get { return _underlineColor }
        set { _underlineColor = newValue; setNeedsDisplay() }
    }

    @IBInspectable
    var isScanButtonHidden: Bool {
        get { return textField?.isScanButtonHidden ?? false }
        set { textField?.isScanButtonHidden = newValue }
    }

    @IBInspectable
    var scanButtonTintColor: UIColor? {
        get { return textField?.rightView?.tintColor }
        set { textField?.rightView?.tintColor = newValue }
    }
}
