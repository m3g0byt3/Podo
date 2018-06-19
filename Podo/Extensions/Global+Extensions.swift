//
//  Global+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 19/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

public func unableToResolve(_ dependency: @autoclosure () -> Any, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("Unable to resolve dependency of type \(dependency())\n in file \(file) at line \(line)")
}
