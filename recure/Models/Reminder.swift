//
//  ContentView.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import Foundation

struct Reminder : Identifiable, Equatable, Codable {
    var id: UUID
    var title: String
    var alertDate: Date
    var cadence: Cadence
    var dueDate: Date
    var description: String
    var dismissed: Bool
    var theme: Theme
    
    enum Cadence: String, CaseIterable, Identifiable, Codable {
        case Daily
        case Weekly
        case Monthly
        case Quarterly
        case Yearly
        var id: Self { self }
    }
    
    init(id: UUID = UUID(), title: String, alertDate: Date, cadence: Cadence, dueDate: Date, description: String, dismissed: Bool, theme: Theme) {
        self.id = id
        self.title = title
        self.alertDate = alertDate
        self.dueDate = dueDate
        self.description = description
        self.dismissed = dismissed
        self.theme = theme
        self.cadence = cadence
    }
    
    init(reminder: Reminder) {
        self.id = reminder.id
        self.title = reminder.title
        self.alertDate = reminder.alertDate
        self.dueDate = reminder.dueDate
        self.description = reminder.description
        self.dismissed = reminder.dismissed
        self.theme = reminder.theme
        self.cadence = reminder.cadence
    }
    
}

extension Reminder {
    static let sampleData: [Reminder] = [
        Reminder(title: "Take Medication",
                 alertDate: Date(timeIntervalSinceNow: 0),
                 cadence: Cadence.Daily,
                 dueDate: Date(timeIntervalSinceNow: 100000),
                 description: "Take 1 tablet aspirin",
                 dismissed: false,
                 theme: .yellow
                ),
        Reminder(title: "Budget",
                 alertDate: Date(timeIntervalSinceNow: 0),
                 cadence: Cadence.Daily,
                 dueDate: Date(timeIntervalSinceNow: 100000),
                 description: "Review cc transactions",
                 dismissed: false,
                 theme: .orange
                )
    ]
    
    static var emptyReminder: Reminder {
        Reminder(title: "",
                 alertDate: Date.now,
                 cadence: Cadence.Daily,
                 dueDate: Date.now,
                 description: "",
                 dismissed: false,
                 theme: .sky)
    }
}
