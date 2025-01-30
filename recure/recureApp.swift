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
    
    var body: some Scene {
        WindowGroup {
            MergedView(alerts: $alerts, reminders: $reminders)
        }
    }
}
