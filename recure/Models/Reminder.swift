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
    var nextAlertDate: Date
    var description: String
    var theme: Theme
    var isValid: Bool = false
    var cadence: Cadence? = nil
    var repeatCount: Int? = nil
    var finalDate: Date? = nil
    var isRepeating: Bool = false
    
    enum Cadence: String, CaseIterable, Identifiable, Codable {
        case Daily
        case Weekly
        case Monthly
        case Quarterly
        case Yearly
        var id: Self { self }
    }
    
    init(id: UUID = UUID(),
         title: String,
         startDate: Date,
         nextAlertDate: Date,
         description: String,
         theme: Theme,
         isRepeating: Bool,
         finalDate: Date? = nil,
         repeatCount: Int? = nil,
         cadence: Cadence? = nil) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.nextAlertDate = nextAlertDate
        self.description = description
        self.theme = theme
        self.cadence = cadence
        self.isRepeating = isRepeating
        if self.isRepeating {
            self.repeatCount = repeatCount
            self.finalDate = finalDate
            self.isRepeating = isRepeating
        }
        self.isValid = true
    }
    
    init(reminder: Reminder) {
        self.id = reminder.id
        self.title = reminder.title
        self.startDate = reminder.startDate
        self.nextAlertDate = reminder.nextAlertDate
        self.description = reminder.description
        self.theme = reminder.theme
        self.isValid = reminder.isValid
        if self.isRepeating {
            self.cadence = reminder.cadence
            self.repeatCount = reminder.repeatCount
            self.finalDate = reminder.finalDate
        }
    }
    
    public mutating func recalculateDueDate() {
        if  (self.isRepeating &&
             ((self.repeatCount ?? 0) > 0 ||
              self.finalDate != nil)) {
            switch self.cadence {
            case .Daily:
                self.nextAlertDate = Calendar.current.date(
                    byAdding: .day, value: 1, to: self.nextAlertDate
                )!
            case .Weekly:
                self.nextAlertDate = Calendar.current.date(
                    byAdding: .day, value: 7, to: self.nextAlertDate
                )!
            case .Monthly:
                self.nextAlertDate = Calendar.current.date(
                    byAdding: .month, value: 1, to: self.nextAlertDate
                )!
            case .Quarterly:
                self.nextAlertDate = Calendar.current.date(
                    byAdding: .month, value: 3, to: self.nextAlertDate
                )!
            case .Yearly:
                self.nextAlertDate = Calendar.current.date(
                    byAdding: .year, value: 1, to: self.nextAlertDate
                )!
            case .none:
                print("Invalid cadence!")
            }
            
            if self.repeatCount != nil {
                self.repeatCount! -= 1
            }
            
            if (((self.finalDate ?? self.nextAlertDate) < self.nextAlertDate) ||
                (self.repeatCount ?? 0) < 0) {
                self.isValid = false
            }
        }
    }
    
    public mutating func normalizeReminder() {
        self.nextAlertDate = self.startDate
        
        // Find the first date we need to alert
        while Date.now > self.nextAlertDate || self.isRepeating == false {
            self.recalculateDueDate()
        }
        
        if self.isRepeating == false {
            self.cadence = nil
            self.repeatCount = nil
            self.finalDate = nil
        }
    }
    
}

extension Reminder {
    static let sampleData: [Reminder] = [
        Reminder(title: "Take Medication",
                 startDate: Date(timeIntervalSinceNow: 0),
                 nextAlertDate: Date(timeIntervalSinceNow: 100000),
                 description: "Take 1 tablet aspirin",
                 theme: .yellow,
                 isRepeating: false
                ),
        Reminder(title: "Budget",
                 startDate: Date(timeIntervalSinceNow: 0),
                 nextAlertDate: Date(timeIntervalSinceNow: 100000),
                 description: "Review cc transactions",
                 theme: .orange,
                 isRepeating: true,
                 finalDate: nil,
                 repeatCount: 5,
                 cadence: Cadence.Daily
                ),
        Reminder(title: "Pay Bills",
                 startDate: Date(timeIntervalSinceNow: 0),
                 nextAlertDate: Date(timeIntervalSinceNow: 100000),
                 description: "You are not super rich yet",
                 theme: .orange,
                 isRepeating: true,
                 finalDate: Date(timeIntervalSinceNow: 200000),
                 cadence: Cadence.Daily
                )
    ]
    
    static var emptyReminder: Reminder {
        Reminder(title: "",
                 startDate: Date.now,
                 nextAlertDate: Date.now,
                 description: "",
                 theme: .sky,
                 isRepeating: false)
    }
}
