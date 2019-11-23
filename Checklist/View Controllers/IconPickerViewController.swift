//
//  IconPickerViewController.swift
//  Checklist
//
//  Created by Mohammed Hamdi on 11/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDeleagte: class {
    func iconPicker(_ controller: IconPickerViewController, didPick iconName: String)
}

class IconPickerViewController: UITableViewController {

    weak var delegate: IconPickerViewControllerDeleagte?
    let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        
        cell.textLabel?.text = icons[indexPath.row]
        cell.imageView?.image = UIImage(named: icons[indexPath.row])
        
        return cell
    }
    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }
}
