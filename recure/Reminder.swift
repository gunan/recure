//
//  ContentView.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import Foundation

struct Reminder {
    var title: String
    var alertDate: Date
    var dueDate: Date
    var description: String
    var dismissed: Bool
}

extension Reminder {
    static let sampleData: [Reminder] = [
        Reminder(title: "Take Medication",
                 alertDate: Date(timeIntervalSinceNow: 0),
                 dueDate: Date(timeIntervalSinceNow: 100000),
                 description: "Take 1 tablet aspirin",
                 dismissed: false
                ),
        Reminder(title: "Budget",
                 alertDate: Date(timeIntervalSinceNow: 0),
                 dueDate: Date(timeIntervalSinceNow: 100000),
                 description: "Review cc transactions",
                 dismissed: false
                )
    ]
}
