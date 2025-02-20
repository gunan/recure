//
//  MergedView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/29/25.
//

import SwiftUI

struct MergedView: View {
    @Binding var alerts: [Alert]
    @Binding var reminders: [Reminder]
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack {
            TabView {
                AlertListView(alerts: $alerts)
                    .tabItem {
                        Label("Alerts", systemImage: "bell")
                    }
                ReminderListView(reminders: $reminders, alerts: $alerts)
                    .tabItem {
                        Label("Reminders", systemImage: "timer")
                    }
            }
        }
    }
}


struct MergedView_Previews: PreviewProvider {
    static var alerts = Alert.sampleData
    static var reminders = Reminder.sampleData
    static var previews: some View {
        MergedView(alerts: .constant(alerts), reminders: .constant(reminders), saveAction: {})
    }
}
