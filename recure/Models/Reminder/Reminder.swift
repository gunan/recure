//
//  ContentView.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import Foundation
import UserNotifications

struct Reminder : Identifiable, Equatable, Codable {
    var id: UUID
    var title: String
    var startDate: Date
    var alertDates: [Date] = []
    var alertIDs: [UUID] = []
    var description: String
    var theme: Theme
    var isValid: Bool = false
    // repetition  stuff
    var isRepeating: Bool = false
    var cadence: Cadence? = nil
    var _repeatCount: Int? = nil
    var repeatCount: Int?{
        set { _repeatCount = newValue }
        get { return _repeatCount }
      }

    var _finalDate: Date? = nil
    var finalDate: Date? {
        set { _finalDate = newValue }
        get { return _finalDate }
      }
    
    
    
    enum Cadence: String, CaseIterable, Identifiable, Codable {
        case Daily
        case Weekly
        case Monthly
        case Quarterly
        case Yearly
        var id: Self { self }
        
        public func toDateComponents() -> DateComponents {
            switch self {
            case .Daily:
                return DateComponents(day:1)
            case .Weekly:
                return DateComponents(weekOfYear:1)
            case .Monthly:
                return DateComponents(month:1)
            case .Quarterly:
                return DateComponents(month:3)
            case .Yearly:
                return DateComponents(year:1)
            }
            
        }
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
        self.alertDates.append(nextAlertDate)
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
        self.alertDates = reminder.alertDates
        self.description = reminder.description
        self.theme = reminder.theme
        self.isValid = reminder.isValid
        if self.isRepeating {
            self.cadence = reminder.cadence
            self.repeatCount = reminder.repeatCount
            self.finalDate = reminder.finalDate
        }
    }
    
    public mutating func resetValidity() {
        self.isValid = true
    }
    
    public mutating func recalculateDueDates(alerts: inout [Alert]) {
        // In case we exhausted all reminders, let's still save the last one.
        var lastReminderDate: Date = self.alertDates.max() ?? self.startDate
        
        // First clear all past dates
        // These should not have pending notifications as well, so safe to just delete.
        self.alertDates.removeAll(where: { $0 < Date.now })
        
        
        // If we have more than 30 alerts scheduled, meh.
        if self.alertDates.count > 30 {
            return
        }
        
        // Now let's see if we are still supposed to repeat stuff
        if self.isRepeating {
            // Make sure we have a cadence to work with
            if self.cadence == nil {
                self.isValid = false
                self.isValid = false
                print("Invalid cadence!")
                return
            }
            
            // Let's see if we have repeat count.
            if (self.repeatCount ?? 0) > 0 {
                while self.repeatCount! > 0 && self.alertDates.count <= 30 {
                    lastReminderDate = Calendar.current.date(byAdding: self.cadence!.toDateComponents(), to: lastReminderDate)!
                    self.repeatCount! -= 1
                    // Let's still check if this is a valid date for a reminder.
                    if lastReminderDate > Date.now {
                        var newAlert = Alert(reminder: self, alertDate: lastReminderDate)
                        newAlert.scheduleNotification()
                        alerts.append(newAlert)
                        self.alertDates.append(lastReminderDate)
                        self.alertIDs.append(newAlert.id)
                    }
                }
            } else if self.finalDate != nil {
                while lastReminderDate < self.finalDate! && self.alertDates.count <= 30 {
                    lastReminderDate = Calendar.current.date(byAdding: self.cadence!.toDateComponents(), to: lastReminderDate)!
                    if lastReminderDate > Date.now {
                        var newAlert = Alert(reminder: self, alertDate: lastReminderDate)
                        newAlert.scheduleNotification()
                        alerts.append(newAlert)
                        self.alertDates.append(lastReminderDate)
                        self.alertIDs.append(newAlert.id)
                    }
                }
            }
        } else {
            if self.alertDates.isEmpty || self.alertIDs.isEmpty {
                // Let's make sure we get this reminder in a consistent state
                if !self.alertIDs.isEmpty {
                    self.clear(alerts: &alerts)
                }
                self.alertDates.removeAll()
                
                // Now we schedule a single reminder for this non-recurring event.
                var newAlert = Alert(reminder: self, alertDate: lastReminderDate)
                newAlert.scheduleNotification()
                alerts.append(newAlert)
                self.alertDates.append(lastReminderDate)
                self.alertIDs.append(newAlert.id)
            }
        }
        
        if self.alertDates.isEmpty {
            // This means we have no more use for this reminder.
            self.isValid = false
        }
    }
    
    public mutating func normalizeReminder(alerts: inout [Alert]) {
        // Check validity of repetition variables.
        if self.isRepeating {
            // repeatCount is considered first
            if (self.repeatCount ?? 0) > 0 {
                self.finalDate = nil
            } else if self.finalDate != nil {
                self.repeatCount = 0
            } else {
                self.isRepeating = false
            }
        } else {
            self.cadence = nil
            self.repeatCount = nil
            self.finalDate = nil
        }
        
        // Then compute some amount of due dates.
        self.recalculateDueDates(alerts: &alerts)
    }
    
    public mutating func clear(alerts: inout [Alert]) {
        // First make sure we unschedule any notifications.
        for var alert in alerts {
            if self.alertIDs.contains(where: {alert.id == $0}) {
                alert.clear()
            }
        }
        
        alerts.removeAll(where: {self.alertIDs.contains($0.id)})
    }
    
}

extension Reminder {
    static let sampleData: [Reminder] = [
        Reminder(title: "Take Medication",
                 startDate: Date(timeIntervalSinceNow: 0),
                 nextAlertDate: Date(timeIntervalSinceNow: -100000),
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
                 theme: .blue,
                 isRepeating: false)
    }
}
