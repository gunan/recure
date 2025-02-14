//
//  EditReminder.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/4/25.
//

import SwiftUI


struct EditReminder : View {
    @Binding var reminder: Reminder
    @Binding var reminders: [Reminder]
    @Environment(\.dismiss) private var dismiss
    @State private var editingReminder: Reminder
    private var creatingNewReminder: Bool
    
    
    init(reminder: Binding<Reminder>) {
        self._reminder = reminder
        self._editingReminder = State(initialValue: reminder.wrappedValue)
        self._reminders = .constant([])
        self.creatingNewReminder = false
    }
    init(reminders: Binding<[Reminder]>) {
        self._reminder = .constant(Reminder.emptyReminder)
        self._editingReminder = State(initialValue: Reminder.emptyReminder)
        self._reminders = reminders
        self.creatingNewReminder = true
    }
    
    var body: some View {
        Form {
            Section(header: Text("Edit reminder")) {
                TextField(
                    "Title", text: $editingReminder.title)
                TextField(
                    "Description", text: $editingReminder.description)
                DatePicker("Start Date", selection: $editingReminder.startDate,
                           in: Date.now...Date.distantFuture)
                List {
                    Picker("Choose Reminder Cadence", selection: $editingReminder.cadence) {
                        ForEach(Reminder.Cadence.allCases) { c in
                            Text(c.rawValue)
                        }
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button("Done") {
                        editingReminder.nextAlertDate = editingReminder.startDate
                        // Find the first date we need to alert
                        while Date.now > editingReminder.nextAlertDate {
                            editingReminder.recalculateDueDate()
                        }
                        
                        // Decide if we need to create a new reminder or editing an existing one.
                        if self.creatingNewReminder {
                            reminders.append(editingReminder)
                        } else {
                            reminder = editingReminder
                        }
                        dismiss()
                    }.buttonStyle(.borderedProminent).tint(.green)
                    Spacer()
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }.buttonStyle(.borderedProminent).tint(.red)
                    Spacer()
                }
                
            }
        }
    }
}

struct EditReminder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditReminder(
                reminder: .constant(Reminder.sampleData[0])
            )
        }
    }
}
