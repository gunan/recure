//
//  DailyReminders.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import SwiftUI

struct DailyReminders {
    var title: String
    var reminders: [String]
    var theme: Theme
}

extension DailyReminders {
    static let sampleData: [DailyReminders] =
    [
        DailyReminders(title: "Dec 1",
                       reminders: ["Take Morning medication",
                                   "Log spending"],
                       theme: .yellow),
        DailyReminders(title: "Dec 2",
                       reminders: ["Take Morning medication",
                                   "Log spending"],
                       theme: .orange),
        DailyReminders(title: "Dec 3",
                       reminders: ["Take Morning medication",
                                   "Log spending",
                                    "Weekly shopping"],
                       theme: .poppy)
    ]
}
