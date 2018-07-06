//
//  UITableViewCell+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 03/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import class UIKit.UITableViewCell

/// Easy management for reusable cells.
protocol ReusableView {

    /// Reuse identifier of the cell class.
    static var reuseIdentifier: String { get }

    /// Cell class itself.
    static var reusableType: AnyClass { get }
}

extension UITableViewCell: ReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var reusableType: AnyClass {
        return self
    }
}
