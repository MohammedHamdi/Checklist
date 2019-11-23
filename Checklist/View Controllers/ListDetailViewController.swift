//
//  ListDetailViewController.swift
//  Checklist
//
//  Created by Mohammed Hamdi on 11/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, IconPickerViewControllerDeleagte {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    var iconName = "Folder"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        if let checklistToEdit = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklistToEdit.name
            iconName = checklistToEdit.iconName
            doneBarButton.isEnabled = true
        }
        iconImage.image = UIImage(named: iconName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    
    // MARK:- Actions
    @IBAction func cancel(_ sender: Any) {
        delegate?.ListDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.iconName = iconName
            delegate?.ListDetailViewController(self, didFinishEditing: checklist)
        } else {
            let list = Checklist(name: textField.text!, iconName: iconName)
            delegate?.ListDetailViewController(self, didFinishAdding: list)
        }
    }
    
    @IBAction func textFieldEditChanged(_ sender: Any) {
        doneBarButton.isEnabled = !textField.text!.isEmpty
    }
    
    // MARK:- Icon Picker View Controller Delegate
    func iconPicker(_ controller: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        iconImage.image = UIImage(named: iconName)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickIcon" {
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
}
