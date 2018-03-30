//
//  AddNewCardViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 26/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AddNewCardViewController: UIViewController, AddNewCardView {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MARK: - IBOutlets

    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var cardNumberTextField: UITextField!

    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBindings()
        cardNumberTextField.becomeFirstResponder()
    }

    // MARK: - AddNewCardView protocol conformance

    var onSaveButtonTap: Completion?
    var onScanButtonTap: Completion?

    // MARK: - Private API

    private func setupBindings() {

        cardNumberTextField.rx.rightOverlayButtonTap?
            .subscribe { [weak self] _ in self?.onScanButtonTap?() }
            .disposed(by: disposeBag)

        saveButton.rx.tap
            .subscribe { [weak self] _ in self?.onSaveButtonTap?() }
            .disposed(by: disposeBag)
    }
}
