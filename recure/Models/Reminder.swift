//
//  ContentView.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import Foundation

struct Reminder : Identifiable {
    var id: UUID
    var title: String
    var alertDate: Date
    var dueDate: Date
    var description: String
    var dismissed: Bool
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, alertDate: Date, dueDate: Date, description: String, dismissed: Bool, theme: Theme) {
        self.id = id
        self.title = title
        self.alertDate = alertDate
        self.dueDate = dueDate
        self.description = description
        self.dismissed = dismissed
        self.theme = theme
    }
}

extension Reminder {
    static let sampleData: [Reminder] = [
        Reminder(title: "Take Medication",
                 alertDate: Date(timeIntervalSinceNow: 0),
                 dueDate: Date(timeIntervalSinceNow: 100000),
                 description: "Take 1 tablet aspirin",
                 dismissed: false,
                 theme: .yellow
                ),
        Reminder(title: "Budget",
                 alertDate: Date(timeIntervalSinceNow: 0),
                 dueDate: Date(timeIntervalSinceNow: 100000),
                 description: "Review cc transactions",
                 dismissed: false,
                 theme: .orange
                )
    ]
}
