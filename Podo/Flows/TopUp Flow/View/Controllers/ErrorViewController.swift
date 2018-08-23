//
//  ErrorViewController.swift
//  Podo
//
//  Created by m3g0byt3 on 23/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import UIKit

final class ErrorViewController: UIViewController, ErrorView {

    // MARK: - Public properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var adapter: ErrorAdapterProtocol!

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: ErrorViewModelProtocol!

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .overCurrentContext }
        set {}
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adapter.presentError(title: viewModel.output.title, message: viewModel.output.message) {
            self.dismiss(animated: false)
        }
    }

    // MARK: - Private API

    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        adapter.dismiss()
        self.dismiss(animated: false)
    }
}
