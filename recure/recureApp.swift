//
//  recureApp.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import SwiftUI

@main
struct recureApp: App {
    @State private var reminders = Reminder.sampleData
    @State private var alerts = Alert.sampleData
    @State private var isLoaded: Bool = false
    
    @StateObject private var reminder_store = ReminderStore()
    @StateObject private var alert_store = AlertStore()
    
    var body: some Scene {
        WindowGroup {
            MergedView(alerts: $alert_store.alerts, reminders: $reminder_store.reminders) {
                Task {
                    do {
                        try await reminder_store.save(reminders: reminder_store.reminders)
                        try await alert_store.save(alerts: alert_store.alerts)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                // Load all data
                do {
                    try await reminder_store.load()
                    try await alert_store.load()
                } catch {
                    // No need to throw error, this is the first launch.
                    print("First app launch")
                }
                self.isLoaded = true
                
                // Make sure we have notification permission.
                let center = UNUserNotificationCenter.current()
                do {
                    try await center.requestAuthorization(options: [.alert, .sound, .badge])
                } catch {
                    // Handle the error here.
                    fatalError(error.localizedDescription)
                }
            }
        }
        .backgroundTask(.appRefresh("Alert Refresh")) {
            await alert_store.refresh()
        }
        .backgroundTask(.appRefresh("Save State")) {
            if await self.isLoaded {
                do {
                    try await reminder_store.save(reminders: reminder_store.reminders)
                    try await alert_store.save(alerts: alert_store.alerts)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
