//
//  Checklist.swift
//  Checklist
//
//  Created by Mohammed Hamdi on 11/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import Foundation

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    var iconName = "No Icon"
    
    init(name: String, iconName: String = "No Icon") {
        super.init()
        self.name = name
        self.iconName = iconName
        sortCheklistItems()
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
    
    // MARK:- Sorting
    func sortCheklistItems() {
        items.sort { (list1, list2) in
            return list1.dueDate.compare(list2.dueDate) == .orderedAscending
        }
    }
}
