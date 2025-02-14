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
    var startDate: Date
    var cadence: Cadence
    var nextAlertDate: Date
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
    
    init(id: UUID = UUID(), title: String, startDate: Date, cadence: Cadence, nextAlertDate: Date, description: String, dismissed: Bool, theme: Theme) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.nextAlertDate = nextAlertDate
        self.description = description
        self.dismissed = dismissed
        self.theme = theme
        self.cadence = cadence
    }
    
    init(reminder: Reminder) {
        self.id = reminder.id
        self.title = reminder.title
        self.startDate = reminder.startDate
        self.nextAlertDate = reminder.nextAlertDate
        self.description = reminder.description
        self.dismissed = reminder.dismissed
        self.theme = reminder.theme
        self.cadence = reminder.cadence
    }
    
}

extension Reminder {
    static let sampleData: [Reminder] = [
        Reminder(title: "Take Medication",
                 startDate: Date(timeIntervalSinceNow: 0),
                 cadence: Cadence.Daily,
                 nextAlertDate: Date(timeIntervalSinceNow: 100000),
                 description: "Take 1 tablet aspirin",
                 dismissed: false,
                 theme: .yellow
                ),
        Reminder(title: "Budget",
                 startDate: Date(timeIntervalSinceNow: 0),
                 cadence: Cadence.Daily,
                 nextAlertDate: Date(timeIntervalSinceNow: 100000),
                 description: "Review cc transactions",
                 dismissed: false,
                 theme: .orange
                )
    ]
    
    static var emptyReminder: Reminder {
        Reminder(title: "",
                 startDate: Date.now,
                 cadence: Cadence.Daily,
                 nextAlertDate: Date.now,
                 description: "",
                 dismissed: false,
                 theme: .sky)
    }
}
