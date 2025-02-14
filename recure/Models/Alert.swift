//
//  Alert.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/8/25.
//

import Foundation

struct Alert : Identifiable, Equatable, Codable {
    var id: UUID
    var reminder: Reminder
    var alertDate: Date
    var dismissed: Bool
    
    init(id: UUID = UUID(), reminder: Reminder) {
        self.id = id
        self.reminder = reminder
        self.alertDate = reminder.nextAlertDate
        self.dismissed = false
    }
    
}

extension Alert {
    static let sampleData: [Alert] = [
        Alert(reminder: Reminder.sampleData[0]),
        Alert(reminder: Reminder.sampleData[1]),
    ]
}

