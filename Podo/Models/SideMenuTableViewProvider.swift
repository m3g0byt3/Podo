//
//  SideMenuTableViewProvider.swift
//  Podo
//
//  Created by m3g0byt3 on 09/02/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import RealmSwift

/**
 Acts as datasource for tableView in side menu
*/
final class SideMenuTableViewProvider: NSObject {

    // MARK: - Properties
    private let entries: Results<SideMenuEntry>

    // MARK: - Inits
    override init() {
        let configuration = Realm.Configuration(fileURL: R.file.sideMenuEntriesRealm(), readOnly: true)
        guard let realm = try? Realm(configuration: configuration) else {
            fatalError("Unable to load configuration database from application bundle.")
        }
        self.entries = realm.objects(SideMenuEntry.self).sorted(byKeyPath: #keyPath(SideMenuEntry.identifier))
        super.init()
    }
}

// MARK: - UITableViewDataSource protocol conformance
extension SideMenuTableViewProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.sideMenuTableViewCell.identifier, for: indexPath)
        if let cell = cell as? SideMenuTableViewCell {
            cell.viewModel = entries[indexPath.row].viewModel
        }
        return cell
    }
}
