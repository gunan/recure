//
//  ReminderListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/3/25.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: [Reminder]
    
    var body: some View {
        List(reminders, id: \.title) { reminder in
            NavigationLink(destination: EditReminder(reminder: reminder)) {
                ReminderCard(reminder: reminder)
            }
            .listRowBackground(reminder.theme.mainColor)
        }
        .navigationTitle("Reminders")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
        }
    }
}


struct ReminderListView_Previews: PreviewProvider {
    static var reminders = Reminder.sampleData
    static var previews: some View {
        ReminderListView(reminders: reminders)
    }
}
