//
//  Global+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 19/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// Throws `fatalError` with additional information about caller and unresolved dependency.
/// - parameters:
///    - dependency: Dependency itself, `Any` type.
///    - file: Name of the file where this function has been called.
///    - line: Line in the file where this function has been called.
/// - returns: `Never`
func unableToResolve(_ dependency: @autoclosure () -> Any, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("Unable to resolve dependency of type \(dependency())\n in file \(file) at line \(line)")
}

/// Throws `fatalError` with additional information about caller.
/// - parameter function: Name of the function where this function has been called.
/// - returns: `Never`
func notImplemented(_ function: StaticString = #function) -> Never {
    fatalError("\(function) not implemented yet!")
}
