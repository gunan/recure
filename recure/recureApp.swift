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
    
    var body: some Scene {
        WindowGroup {
            ReminderListView(reminders: $reminders)
        }
    }
}
