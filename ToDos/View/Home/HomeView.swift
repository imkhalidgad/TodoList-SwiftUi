//
//  ContentView.swift
//  ToDos
//
//  Created by Khalid Gad on 12/07/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var reminderList: [ReminderList]
    @State private var path = [ReminderList]()
    
    let colums = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List {
                    Section {
                        VStack {
                            LazyVGrid(columns: colums, spacing: 10) {
                                ForEach(reminderList.filter { $0.pinned }.prefix(4)) { reminders in
                                    ListCardView(reminderList: reminders)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
                    
                    Section {
                        ForEach(reminderList) { reminders in
                            NavigationLink {
                                ReminderListView(reminderList: reminders)
                            } label: {
                                ReminderListRowView(reminderList: reminders)
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 15))
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                if reminders.pinned {
                                    Button {
                                        reminders.pinned = false
                                        try? modelContext.save()
                                    } label: {
                                        Label("Unpin", systemImage: "pin.slash")
                                    }
                                    .tint(.gray)
                                } else if reminderList.filter({ $0.pinned }).count < 4 {
                                    Button {
                                        reminders.pinned = true
                                        try? modelContext.save()
                                    } label: {
                                        Label("Pin", systemImage: "pin")
                                    }
                                    .tint(.mint)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    } header: {
                        Text("My Lists")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Reminders")
            .navigationDestination(for: ReminderList.self, destination: CreateSectionView.init)
            .toolbar {
                Button("Add Section", systemImage: "plus", action: addSection)
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.mintGreen).frame(width: 36, height: 36))
            }
            .background(Color.mintGreen.edgesIgnoringSafeArea(.all))
            .overlay {
                Group {
                    if reminderList.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Reminders", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding reminders to see your list.")
                        }, actions: {
                            Button("Add Reminder", action: addSection)
                        })
                        .offset(y: -60)
                    }
                }
            }
        }
    }
    
    func addSection() {
        let section = ReminderList()
        modelContext.insert(section)
        path = [section]
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let reminderLists = reminderList[index]
            modelContext.delete(reminderLists)
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: ReminderList.self, inMemory: true)
}
