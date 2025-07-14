//
//  ToDosApp.swift
//  ToDos
//
//  Created by Khalid Gad on 12/07/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDosApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: ReminderList.self)
    }
}
