//
//  ListCardView.swift
//  ToDos
//
//  Created by Khalid Gad on 12/07/2025.
//

import SwiftUI
import SwiftData

struct ListCardView: View {
    @Bindable var reminderList: ReminderList
    @State private var linkIsActive = false
    
    var body: some View {
        Button {
            linkIsActive = true
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    listIcon
                    Spacer()
                    Text("\(reminderList.reminder.count)")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.trailing)
                }
                Text(reminderList.name)
                    .font(.system(.body, design: .rounded, weight: .bold))
                    .foregroundColor(.secondary)
            }
            .padding(5)
            .padding(.horizontal, 5)
            .background(Color.mintGreen.opacity(0.15))
            .cornerRadius(10)
        }
        .overlay(
            NavigationLink(isActive: $linkIsActive,
                           destination: { ReminderListView(reminderList: reminderList) },
                           label: { EmptyView() }
                          ).opacity(0)
        ).buttonStyle(.plain)
    }
    
    var listIcon: some View {
        ZStack {
            Circle()
                .fill(Color.mintGreen)
                .frame(width: 27)
            Image(systemName: reminderList.iconName)
                .font(.footnote)
                .foregroundColor(.white)
                .bold()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ReminderList.self, configurations: config)
        let example = ReminderList(name: "Today", iconName: "sun.max.fill", reminder: [Reminder(name: "Walk the dog")])
        
        return ListCardView(reminderList: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create a model container.")
    }
}
