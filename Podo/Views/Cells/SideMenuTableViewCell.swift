//
//  SideMenuTableViewCell.swift
//  Podo
//
//  Created by m3g0byt3 on 09/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class SideMenuTableViewCell: UITableViewCell {

    var viewModel: SideMenuEntryViewModel? {
        didSet {
            textLabel?.text = viewModel?.title
        }
    }
}
