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
                do {
                    try await reminder_store.load()
                    try await alert_store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
