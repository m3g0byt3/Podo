//
//  BSKTransactionDelegateProxy.swift
//  Podo
//
//  Created by m3g0byt3 on 10/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import BSK
import RxSwift
import RxCocoa

extension BSKAdapter: HasDelegate {

    public typealias Delegate = BSKTransactionDelegate
}

final class BSKTransactionDelegateProxy: DelegateProxy<BSKAdapter, BSKTransactionDelegate>,
                                         DelegateProxyType,
                                         BSKTransactionDelegate {

    /// Typed parent object.
    weak private(set) var adapter: BSKAdapter?

    /// - parameter adapter: Parent object for delegate proxy.
    init(adapter: ParentObject) {
        self.adapter = adapter
        super.init(parentObject: adapter, delegateProxy: BSKTransactionDelegateProxy.self)
    }

    // Register known implementations
    static func registerKnownImplementations() {
        self.register { BSKTransactionDelegateProxy(adapter: $0) }
    }

    // MARK: - Private properties

    // Workaround to make delegate proxy work with pure Swift protocol
    // See details here: https://github.com/ReactiveX/RxSwift/issues/1442
    private lazy var _confirmationRequest = PublishSubject<URLRequest>()
    private lazy var _transactionDidFail = PublishSubject<BSKError>()
    private lazy var _transactionDidComplete = PublishSubject<Void>()

    // MARK: - Public properties

    var confirmationRequest: Observable<URLRequest> { return _confirmationRequest.asObservable() }
    var transactionFailed: Observable<BSKError> { return _transactionDidFail.asObservable() }
    var transactionCompleted: Observable<Void> { return _transactionDidComplete.asObservable() }

    // MARK: - BSKTransactionDelegate protocol conformance

    func didReceiveConfirmationRequest(_ request: URLRequest) {
        _confirmationRequest.onNext(request)
    }

    func transactionDidFailWithError(_ error: BSKError) {
        _transactionDidFail.onNext(error)
    }

    func transactionDidComplete() {
        _transactionDidComplete.onNext(())
    }
}
