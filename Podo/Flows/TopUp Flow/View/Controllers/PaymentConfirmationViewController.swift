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

    // MARK: - Constants

    private static let keyPath = #keyPath(UIApplication.isNetworkActivityIndicatorVisible)

    // MARK: - IBOutlets

    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var webView: UIWebView!

    // MARK: - Private properties

    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    private let disposeBag = DisposeBag()

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: PaymentConfirmationViewModelProtocol!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - PaymentConfirmationView protocol conformance

    var onPaymentCancel: Completion?
    var onPaymentComplete: Completion?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Private API

    private func setupUI() {
        let activityButton = UIBarButtonItem(customView: activityIndicator)
        navigationBar.items?.first?.leftBarButtonItem = activityButton
    }

    private func setupBindings() {
        viewModel.output.confirmationRequest
            .asDriver(onErrorJustReturn: .blank)
            .drive(webView.rx.loadRequest)
            .disposed(by: disposeBag)

        viewModel.output.validator
            .asObservable()
            .map { $0 as UIWebViewDelegate }
            .bind(to: webView.rx.setDelegate)
            .disposed(by: disposeBag)

        viewModel.output.paymentCompleted
            .subscribe(onCompleted: { [weak self] in
                self?.onPaymentComplete?()
            })
            .disposed(by: disposeBag)

        cancelButton.rx.tap
            .asObservable()
            .subscribe { [weak self] _ in
                self?.onPaymentCancel?()
            }
            .disposed(by: disposeBag)

        UIApplication.shared.rx.observeWeakly(Bool.self, type(of: self).keyPath)
            .filterNil()
            .asDriver(onErrorJustReturn: false)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

// MARK: - UINavigationBarDelegate protocol conformance

extension PaymentConfirmationViewController: UINavigationBarDelegate {

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
