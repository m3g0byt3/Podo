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

final class AddNewCardViewController: UIViewController, AddNewCardView, TrainIconTitleView, KeyboardHandling {

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: AddNewCardViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - IBOutlets

    @IBOutlet private weak var cardView: GradientView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var cardNumberTextField: UITextField!
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

    private func setupBindings() {
        cardNumberTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .throttle(Constant.ThrottleDuration.textField, scheduler: MainScheduler.instance)
            .bind(to: viewModel.cardNumberInput)
            .disposed(by: disposeBag)

        colorButtons.enumerated().forEach { index, button in
            button.rx.tap
                .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [unowned self] in
                    self.viewModel.themeChanged.onNext(index)
                })
                .disposed(by: disposeBag)
        }

        cardNumberTextField.rx.rightOverlayButtonTap?
            .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
            .subscribe { [unowned self] _ in self.onScanButtonTap?() }
            .disposed(by: disposeBag)

        saveButton.rx.tap
            .throttle(Constant.ThrottleDuration.button, scheduler: MainScheduler.instance)
            .do(onNext: { [unowned self] _ in self.onSaveButtonTap?() })
            .bind(to: viewModel.saveState)
            .disposed(by: disposeBag)

        viewModel.cardNumberOutput
            .drive(cardNumberTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel.isCardValid
            .drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.cardTheme
            .map { [$0.firstGradientColor, $0.secondGradientColor] }
            .drive(cardView.rx.gradientColors)
            .disposed(by: disposeBag)
    }
}
