//
//  TableViewDelegate.swift
//  Podo
//
//  Created by m3g0byt3 on 03/12/2017.
//  Copyright © 2017 m3g0byt3. All rights reserved.
//

import UIKit

class TableViewProvider: NSObject {

}

extension TableViewProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Add actual implementation
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Add actual implementation
        return tableView.dequeueReusableCell(withIdentifier: R.nib.cardsTableViewCell.identifier, for: indexPath)
    }
}
