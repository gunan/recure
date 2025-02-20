//
//  ReminderListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/3/25.
//

import SwiftUI

struct ReminderListView: View {
    @Binding var reminders: [Reminder]
    @Binding var alerts: [Alert]
    
    var body: some View {
        NavigationStack {
            List($reminders, id: \.title) { $reminder in
                NavigationLink(destination: EditReminder(reminder: $reminder, alerts: $alerts)) {
                    ReminderCard(reminder: reminder)
                }
                .listRowBackground(reminder.theme.mainColor)
            }
            .navigationTitle("Reminders")
            .toolbar {
                NavigationLink(
                    destination: EditReminder(
                        reminders: $reminders,
                        alerts: $alerts
                    )) {
                        Button("plus", systemImage: "plus", action: {})
                    }
            }
        }
    }
}


struct ReminderListView_Previews: PreviewProvider {
    static var reminders = Reminder.sampleData
    static var alerts = Alert.sampleData
    static var emptys = Array<Reminder>()
    static var previews: some View {
        ReminderListView(reminders: .constant(reminders), alerts: .constant(alerts))
        // ReminderListView(reminders: .constant(emptys))
    }
}
