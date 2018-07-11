//
//  NSObject+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 07/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation
import ObjectiveC

enum SwizzleError {

    enum Original: Error {
        case unableToGetMethod
        case unableToGetTypeEncoding
    }

    enum Swizzled: Error {
        case unableToGetMethod
        case unableToGetTypeEncoding
    }
}

extension NSObject {

    /**
     Swizzle selected methods.
     - parameters:
        - originalSelector: Selector for method to be replaced
        - swizzledSelector: Selector for method to be added
     - throws: `SwizzleError` if call to `class_getInstanceMethod` or `method_getTypeEncoding`
                returns `nil` for original or replacement methods.
     ```
     // Every unique method should be swizzled EXACTLY one time, so perform swizzling in the following manner (swifty "dispatch_once"):

     extension NSObject {

        /// ⚠️ Dispatched once. ⚠️
        static let swizzleSomeMethod: () -> Void = {
            try? swizzleMethod(from: #selector(NSObject.doesNotRecognizeSelector(_:)),
                               to: #selector(NSObject.swizzledDoesNotRecognizeSelector))
            return {}
        }()

        /// Replacement method
        @objc
        private func swizzledDoesNotRecognizeSelector(_ aSelector: Selector!) -> Any {
            print("Swizzled!")
            return swizzledDoesNotRecognizeSelector(_:)
        }
     }
     ```
     */
    public class func swizzleMethod(from originalSelector: Selector, to swizzledSelector: Selector) throws {

        #if DEBUG
        print("⚠️ Perform swizzling from method \"\(originalSelector)\" to the method \"\(swizzledSelector)\" in class \"\(self)\". ⚠️")
        #endif

        guard let originalMethod = class_getInstanceMethod(self, originalSelector) else {
            throw SwizzleError.Original.unableToGetMethod
        }
        guard let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else {
            throw SwizzleError.Swizzled.unableToGetMethod
        }
        guard let swizzledMethodTypeEncoding = method_getTypeEncoding(swizzledMethod) else {
            throw SwizzleError.Swizzled.unableToGetTypeEncoding
        }

        let swizzledMethodImplementation = method_getImplementation(swizzledMethod)
        let isMethodExist = !class_addMethod(self,
                                             originalSelector,
                                             swizzledMethodImplementation,
                                             swizzledMethodTypeEncoding)
        if isMethodExist {
            // The class already contains a method implementation with that name
            method_exchangeImplementations(originalMethod, swizzledMethod)
        } else {
            // Method was added successfull
            guard let originalMethodTypeEncoding = method_getTypeEncoding(originalMethod) else {
                throw SwizzleError.Original.unableToGetTypeEncoding
            }
            let originalMethodImplementation = method_getImplementation(originalMethod)
            _ = class_replaceMethod(self,
                                    swizzledSelector,
                                    originalMethodImplementation,
                                    originalMethodTypeEncoding)
        }
    }
}
