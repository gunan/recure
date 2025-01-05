//
//  EditReminder.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/4/25.
//

import SwiftUI


struct EditReminder : View {
    let reminder: Reminder
    
    var body: some View {
        List {
            Section(header: Text(reminder.title)) {
                TextField(text: $reminder.title)
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text(reminder.description)
                }
            }
        }
    }
}

struct EditReminder_Previews: PreviewProvider {
    static var previews: some View {
        EditReminder(reminder: Reminder.sampleData[0])
    }
}
