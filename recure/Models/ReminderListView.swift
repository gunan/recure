//
//  ReminderListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/3/25.
//

import SwiftUI

struct ReminderListView: View {
    @Binding var reminders: [Reminder]
    
    var body: some View {
        NavigationStack {
            List($reminders, id: \.title) { $reminder in
                NavigationLink(destination: EditReminder(reminder: $reminder)) {
                    ReminderCard(reminder: reminder)
                }
                .listRowBackground(reminder.theme.mainColor)
            }
            .navigationTitle("Reminders")
            .toolbar {
                NavigationLink(
                    destination: EditReminder(
                        reminders: $reminders
                    )) {
                        Button("plus", systemImage: "plus", action: {})
                    }
            }
        }
    }
}


struct ReminderListView_Previews: PreviewProvider {
    static var reminders = Reminder.sampleData
    static var emptys = Array<Reminder>()
    static var previews: some View {
        // ReminderListView(reminders: .constant(reminders))
        ReminderListView(reminders: .constant(emptys))
    }
}
