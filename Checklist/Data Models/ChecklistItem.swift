//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Mohammed Hamdi on 11/3/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var title = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemId = -1
    
    init(title: String, checked: Bool = false) {
        super.init()
        self.title = title
        self.checked = checked
        itemId = DataModel.nextChecklistItemID()
    }
    
    deinit {
        removeNotification()
    }
    
    func toggleCheckmark() {
        checked = !checked
    }
    
    // MARK:- Local Notification
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = title
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(itemId)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            //print("Scheduled: \(request) for itemID: \(itemId)")
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemId)"])
    }
}
