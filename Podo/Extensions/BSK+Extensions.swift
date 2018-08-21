//
//  BSK+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 20/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import BSK

extension BSKError: LocalizedError {

    public var errorDescription: String? {
        switch self {

        case .underlying(let error as LocalizedError):
            return error.localizedDescription

        case .underlying(let error as CustomNSError):
            return R.string.localizable.unknownUnderlyingErrorD(error.errorCode)

        default:
            return String(describing: self).localized
        }
    }

    public var isRecoverable: Bool {
        switch self {
        case .unableToMapResponse, .unableToTopUp, .wrongCardNumber, .underlying: return false
        default: return true
        }
    }
}
