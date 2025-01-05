//
//  EditReminder.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/4/25.
//

import SwiftUI


struct EditReminder : View {
    @Binding var reminder: Reminder
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("Edit reminder")) {
                TextField(
                    "Title", text: $reminder.title)
                TextField(
                    "Description", text: $reminder.description)
                DatePicker("Start Date", selection: $reminder.alertDate)
                List {
                    Picker("Choose Reminder Cadence", selection: $reminder.cadence) {
                        ForEach(Reminder.Cadence.allCases) { c in
                            Text(c.rawValue)
                        }
                    }
                }
                    Button("Done") {
                        dismiss()
                    }
                    Spacer()
                    Button("Cancel") {
                        dismiss()
                    }
                
            }
        }
    }
}

struct EditReminder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditReminder(reminder: .constant(Reminder.sampleData[0]))
        }
    }
}
