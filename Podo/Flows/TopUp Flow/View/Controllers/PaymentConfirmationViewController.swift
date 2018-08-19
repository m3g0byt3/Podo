//
//  PaymentConfirmationViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 13/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit
import BSK
import Result
import RxSwift
import RxCocoa

class PaymentConfirmationViewController: UIViewController,
                                         PaymentConfirmationView {

    // MARK: - IBOutlets

    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var webView: UIWebView!

    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentConfirmationViewModelProtocol!
    private let disposeBag = DisposeBag()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - PaymentConfirmationView protocol conformance

    var onPaymentFinish: ((Result<Void, BSKError>) -> Void)?
    var onPaymentCancel: Completion?

    // MARK: - Lifecycle

    deinit {
        print("🔴 deinit \(self) 🔴")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    // MARK: - Private API

    private func setupBindings() {
        viewModel.output.confirmationRequest
            .asDriver(onErrorJustReturn: .blank)
            .drive(webView.rx.loadRequest)
            .disposed(by: disposeBag)
    }


        cancelButton.rx.tap
            .asObservable()
            .subscribe { [weak self] _ in
                self?.onPaymentCancel?()
            }
            .disposed(by: disposeBag)
    }
}

extension PaymentConfirmationViewController: UINavigationBarDelegate {

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
