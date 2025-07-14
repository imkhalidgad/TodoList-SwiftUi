//
//  CreateSectionView.swift
//  ToDos
//
//  Created by Khalid Gad on 12/07/2025.
//

import SwiftUI
import SwiftData

struct CreateSectionView: View {
    @Bindable var reminderList: ReminderList
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $reminderList.name)
            
            Section("Icon") {
                Picker("Icon", selection: $reminderList.iconName) {
                    Image(systemName: "house").tag("house")
                    Image(systemName: "heart").tag("heart")
                    Image(systemName: "calendar").tag("calendar")
                    Image(systemName: "flag.fill").tag("flag.fill")
                    Image(systemName: "sun.max.fill").tag("sun.max.fill")
                    Image(systemName: "graduationcap").tag("graduationcap")
                    Image(systemName: "exclamationmark.3").tag("exclamationmark.3")
                }
                .pickerStyle(.segmented)
            }
        }
        .background(Color.mintGreen.opacity(0.1))
        Button(action: {
            // Check if there are fewer than 4 pinned lists
            let pinnedCount = (try? modelContext.fetch(FetchDescriptor<ReminderList>(predicate: #Predicate { $0.pinned })))?.count ?? 0
            if pinnedCount < 4 {
                reminderList.pinned = true
            }
            modelContext.insert(reminderList)
            try? modelContext.save()
            dismiss()
        }) {
            Text("Add")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.mintGreen)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline)
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Add Segment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CreateSectionView(reminderList: ReminderList())
}
