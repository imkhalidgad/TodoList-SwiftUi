//
//  Reminder.swift
//  ToDos
//
//  Created by Khalid Gad on 12/07/2025.
//

import Foundation
import SwiftData

@Model
final class Reminder {
    var name: String
    var isCompleted = false
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }
}
