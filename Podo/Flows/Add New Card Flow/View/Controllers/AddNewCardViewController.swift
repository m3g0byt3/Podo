//
//  AddNewCardViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 26/03/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class AddNewCardViewController: UIViewController,
                                      AddNewCardView,
                                      TrainIconTitleView,
                                      KeyboardHandling {

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddNewCardViewModelProtocol!
    private let disposeBag = DisposeBag()

    // MARK: - IBOutlets

    @IBOutlet private weak var cardView: GradientView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var cardNumberTextField: UITextField!
    @IBOutlet private weak var cardNumberPrefixLabel: UILabel!
    @IBOutlet private var colorButtons: [UIButton]!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        beginKeyboardHandling()
        cardNumberTextField.becomeFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endKeyboardHandling()
    }

    // MARK: - KeyboardHandling protocol conformance

    var manageableViews: [UIView] { return [view] }

    // MARK: - AddNewCardView protocol conformance

    var onSaveButtonTap: Completion?
    var onScanButtonTap: Completion?

    // MARK: - Private API

    // swiftlint:disable:next function_body_length
    private func setupBindings() {
        cardNumberTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.cardNumberInput)
            .disposed(by: disposeBag)

        for (index, button) in colorButtons.enumerated() {
            button.rx.tap
                .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] in
                    self?.viewModel.input.themeChanged.onNext(index)
                })
                .disposed(by: disposeBag)
        }

        cardNumberTextField.rx.rightOverlayButtonTap?
            .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.onScanButtonTap?()
            }
            .disposed(by: disposeBag)

        saveButton.rx.tap
            .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                self?.onSaveButtonTap?()
            })
            .bind(to: viewModel.input.saveState)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberOutput
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cardNumberTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberPrefix
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cardNumberPrefixLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.cardNumberPlaceholder
            .asDriver(onErrorJustReturn: Constant.Placeholder.empty)
            .drive(cardNumberTextField.rx.placeholder)
            .disposed(by: disposeBag)

        viewModel.output.isCardValid
            .asDriver(onErrorJustReturn: false)
            .drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.output.cardTheme
            .map { [$0.firstGradientColor, $0.secondGradientColor] }
            .asDriver(onErrorJustReturn: [])
            .drive(cardView.rx.gradientColors)
            .disposed(by: disposeBag)
    }
}
