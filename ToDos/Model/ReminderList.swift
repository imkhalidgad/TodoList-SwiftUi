//
//  ReminderList.swift
//  ToDos
//
//  Created by Khalid Gad on 12/07/2025.
//

import Foundation
import SwiftData

@Model
final class ReminderList {
    var name: String
    var iconName: String
    @Relationship(deleteRule: .cascade) var reminder = [Reminder]()
    var pinned: Bool = false
    
    init(name: String = "", iconName: String = "list.bullet", reminder: [Reminder] = [Reminder](), pinned: Bool = false) {
        self.name = name
        self.iconName = iconName
        self.reminder = reminder
        self.pinned = pinned
    }
}
