//
//  InputAccessoryViewProtocol.swift
//  Podo
//
//  Created by m3g0byt3 on 17/07/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/// Just a placeholder to avoid unnecessary casts for UIKit classes that have settable (RW) `inputAccessoryView` property.
protocol _InputAccessoryViewProtocol: class {

    /// The custom accessory view to display when the text view becomes the first responder.
    var inputAccessoryView: UIView? { get set }
}

extension UITextField: _InputAccessoryViewProtocol {}

extension UITextView: _InputAccessoryViewProtocol {}

extension UISearchBar: _InputAccessoryViewProtocol {}
