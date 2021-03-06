//
//  Observable+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 22/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import RxSwift

/// Originally from here: https://github.com/RxSwiftCommunity/RxOptional/blob/master/Source/Observable%2BOptional.swift
/// Some code originally from here:
/// https://github.com/artsy/eidolon/blob/24e36a69bbafb4ef6dbe4d98b575ceb4e1d8345f/Kiosk/Observable%2BOperators.swift#L42-L62
/// Credit to Artsy and @ashfurrow
extension ObservableType where E: OptionalType {

    /// Unwraps and filters out `nil` elements.
    /// - returns: `Observable` of source `Observable`'s elements, with `nil` elements filtered out.
    func filterNil() -> Observable<E.Wrapped> {
        return self.flatMap { element -> Observable<E.Wrapped> in
            guard let value = element.value else {
                return Observable<E.Wrapped>.empty()
            }
            return Observable<E.Wrapped>.just(value)
        }
    }

    /// Map `.some` to `true` and `.none` to `false`.
    /// - returns: `true` if source `Observable` contains non-nil element, false otherwise.
    func mapNil() -> Observable<Bool> {
        return self.map { $0.value != nil }
    }
}

extension ObservableType where E == String {

    /// Filters out non-numeric characters from observable of type `Observable<String>`.
    /// - Returns: `Observable<String>` with non-numeric characters elements filtered out.
    public func filterNonNumeric() -> Observable<E> {
        let notNumericSet = CharacterSet.decimalDigits.inverted
        let notNumericReplacement = ""

        return self.map { string in
            var newString = string

            while let range = newString.rangeOfCharacter(from: notNumericSet) {
                newString = newString.replacingCharacters(in: range, with: notNumericReplacement)
            }

            return newString
        }
    }
}

extension ObservableType {

    /// Map `error` event from source observable to the `Observable<Void>`.
    /// - Returns: `Observable<Void>` when source observable emits an error.
    public func thenIfError() -> Observable<Void> {
        return self.map(Optional.init)
            .catchErrorJustReturn(nil)
            .mapNil()
            .filter(!)
            .map { _ in }
    }
}
