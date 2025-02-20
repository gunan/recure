//
//  Alert.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/8/25.
//

import Foundation
import UserNotifications

struct Alert : Identifiable, Equatable, Codable {
    var id: UUID
    var reminder: Reminder
    var alertDate: Date
    var dismissed: Bool = false
    var isVisible: Bool = false
    var notificationID: String? = nil
    
    init(id: UUID = UUID(), reminder: Reminder) {
        self.id = id
        self.reminder = reminder
        self.alertDate = reminder.alertDates.first ?? reminder.startDate
    }
    
    init(id: UUID = UUID(), reminder: Reminder, alertDate: Date) {
        self.id = id
        self.reminder = reminder
        self.alertDate = alertDate
    }
    
    public mutating func scheduleNotification() {
        let uuidString = UUID().uuidString
        if self.notificationID != nil { return }
        
        let content = UNMutableNotificationContent()
        content.title = self.reminder.title
        content.body = self.reminder.description
        
        content.sound = UNNotificationSound.default
        
        let dateComps: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self.alertDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComps, repeats: false)
        
        let request = UNNotificationRequest(identifier: self.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        self.notificationID = uuidString
        return
    }
    
    public mutating func clear() {
        if self.notificationID == nil { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.notificationID!])
        self.notificationID = nil
    }
}

extension Alert {
    static let sampleData: [Alert] = [
        Alert(reminder: Reminder.sampleData[0]),
        Alert(reminder: Reminder.sampleData[1]),
    ]
}

