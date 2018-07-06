//
//  UITableView+Extensions.swift
//  Podo
//
//  Created by m3g0byt3 on 03/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import class UIKit.UITableView
import class UIKit.UITableViewCell
import struct Foundation.IndexPath

extension UITableView {

    /**
     Strongly-typed reusable cell dequeueing.
     - parameter indexPath: The index path specifying the location of the cell.
     - returns: Cell instance of type `T`
     - throws: ❗️May throw `fatalError` if generic type of cell (`T`) does not registered on the `tableView` instance.❗️
     ```
     let cell: SomeCustomCell = tableView.dequeueReusableCell(for: indexPath)
     ```
     */
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            print("""
                Unable to dequeue cell of type \(T.self).
                Check if cell that conforms to `ReusableView` protocol registered on the `tableView` instance using `func register(_:)`
                """)
            fatalError("Unable to dequeue cell of type \(T.self)")
        }

        return cell
    }

    /**
     Register cell that conforms to `ReusableView` protocol.
     - parameter aReusable: Cell class that conforms to `ReusableView` protocol.
     */
    func register(_ aReusable: ReusableView.Type) {
        register(aReusable.reusableType, forCellReuseIdentifier: aReusable.reuseIdentifier)
    }
}
