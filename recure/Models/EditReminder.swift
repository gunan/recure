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
    
    func recalculateDueDate() {
        switch editingReminder.cadence {
        case .Daily:
            editingReminder.dueDate = Calendar.current.date(
                byAdding: .day, value: 1, to: editingReminder.alertDate
            )!
        case .Weekly:
            editingReminder.dueDate = Calendar.current.date(
                byAdding: .day, value: 7, to: editingReminder.alertDate
            )!
        case .Monthly:
            editingReminder.dueDate = Calendar.current.date(
                byAdding: .month, value: 1, to: editingReminder.alertDate
            )!
        case .Quarterly:
            editingReminder.dueDate = Calendar.current.date(
                byAdding: .month, value: 3, to: editingReminder.alertDate
            )!
        case .Yearly:
            editingReminder.dueDate = Calendar.current.date(
                byAdding: .year, value: 1, to: editingReminder.alertDate
            )!
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Edit reminder")) {
                TextField(
                    "Title", text: $editingReminder.title)
                TextField(
                    "Description", text: $editingReminder.description)
                DatePicker("Start Date", selection: $editingReminder.alertDate,
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
