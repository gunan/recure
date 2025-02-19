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
    @Binding var alerts: [Alert]
    
    @Environment(\.dismiss) private var dismiss
    @State private var editingReminder: Reminder
    private var creatingNewReminder: Bool
    @State private var errorMessage: String? = nil
    
    @State private var selectRepetitionCount: Bool = false
    @State private var untilDate: Date = Date()
    @State private var repetitionCount: Int = 0
    
    init(reminder: Binding<Reminder>, alerts: Binding<[Alert]>) {
        self._reminder = reminder
        self._editingReminder = State(initialValue: reminder.wrappedValue)
        self._reminders = .constant([])
        self._alerts = alerts
        self.creatingNewReminder = false
    }
    init(reminders: Binding<[Reminder]>, alerts: Binding<[Alert]>) {
        self._reminder = .constant(Reminder.emptyReminder)
        self._editingReminder = State(initialValue: Reminder.emptyReminder)
        self._reminders = reminders
        self._alerts = alerts
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
                Toggle("Repeat?", isOn: $editingReminder.isRepeating)
                
                if (editingReminder.isRepeating) {
                    List {
                        Picker("Choose Reminder Cadence", selection: $editingReminder.cadence) {
                            ForEach(Reminder.Cadence.allCases) { c in
                                Text(c.rawValue)
                            }
                        }
                    }.disabled(!editingReminder.isRepeating)
                    Picker("Repeat until", selection: $selectRepetitionCount) {
                        Text("Date").tag(false)
                        Text("Times").tag(true)
                    }.pickerStyle(.segmented)
                    
                    if selectRepetitionCount {
                        HStack {
                            Text("Count")
                            Text("\(repetitionCount)")
                            Stepper("", value: $repetitionCount, in: 1...100)
                        }
                    } else {
                        DatePicker("End date",
                                   selection: $untilDate,
                                   in: editingReminder.startDate...Date.distantFuture)
                    }
                }
                HStack {
                    Spacer()
                    Button("Done") {
                        // Because of the optional business, resolve indirection here.
                        if (editingReminder.isRepeating) {
                            if selectRepetitionCount {
                                editingReminder.repeatCount = repetitionCount
                            } else {
                                editingReminder.finalDate = untilDate
                            }
                        }
                        
                        editingReminder.normalizeReminder()
                        if editingReminder.isValid {
                            // Decide if we need to create a new reminder or editing an existing one.
                            if self.creatingNewReminder {
                                reminders.append(editingReminder)
                            } else {
                                reminder.clear(alerts: &alerts)
                                reminder = editingReminder
                            }
                            dismiss()
                        } else {
                            self.errorMessage = "No future alert date can be computed."
                        }
                    }.buttonStyle(.borderedProminent).tint(.green)
                    Spacer()
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }.buttonStyle(.borderedProminent).tint(.red)
                    Spacer()
                }
                if self.errorMessage != nil && self.errorMessage != "" {
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text(self.errorMessage!)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                
            }
        }
    }
}

struct EditReminder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditReminder(
                reminder: .constant(Reminder.sampleData[0]),
                alerts: .constant(Alert.sampleData)
            )
        }
    }
}
