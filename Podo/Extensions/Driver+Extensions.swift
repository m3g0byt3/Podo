//
//  Driver+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 22/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/*
 Originally from here: https://github.com/RxSwiftCommunity/RxOptional/blob/master/Source/Driver%2BOptional.swift
 */
extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E: OptionalType {
    /**
     Unwraps and filters out `nil` elements.
     - returns: `Driver` of source `Driver`'s elements, with `nil` elements filtered out.
     */
    func filterNil() -> Driver<E.Wrapped> {
        return self.flatMap { element -> Driver<E.Wrapped> in
            guard let value = element.value else {
                return Driver<E.Wrapped>.empty()
            }
            return Driver<E.Wrapped>.just(value)
        }
    }
}
