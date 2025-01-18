//
//  Alert.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/8/25.
//

import Foundation

struct Alert : Identifiable, Equatable {
    var id: UUID
    var reminder: Reminder
    var alertDate: Date
    var dismissed: Bool
    
    private mutating func recalculateDueDate() {
        switch self.reminder.cadence {
        case .Daily:
            self.reminder.alertDate = Calendar.current.date(
                byAdding: .day, value: 1, to: self.reminder.alertDate
            )!
        case .Weekly:
            self.reminder.alertDate = Calendar.current.date(
                byAdding: .day, value: 7, to: self.reminder.alertDate
            )!
        case .Monthly:
            self.reminder.alertDate = Calendar.current.date(
                byAdding: .month, value: 1, to: self.reminder.alertDate
            )!
        case .Quarterly:
            self.reminder.alertDate = Calendar.current.date(
                byAdding: .month, value: 3, to: self.reminder.alertDate
            )!
        case .Yearly:
            self.reminder.alertDate = Calendar.current.date(
                byAdding: .year, value: 1, to: self.reminder.alertDate
            )!
        }
    }
    
    init(id: UUID = UUID(), reminder: Reminder) {
        self.id = id
        self.reminder = reminder
        self.alertDate = reminder.alertDate
        self.dismissed = false
        
        self.recalculateDueDate()
    }
    
}

extension Alert {
    static let sampleData: [Alert] = [
        Alert(reminder: Reminder.sampleData[0]),
        Alert(reminder: Reminder.sampleData[1]),
    ]
}

