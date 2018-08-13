//
//  URLRequest+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 13/08/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension URLRequest {

    /// Blank URLRequest (`about:blank`).
    static var blank: URLRequest {
        // swiftlint:disable:next force_unwrapping
        let url = URL(string: "about:blank")!
        return URLRequest(url: url)
    }
}
