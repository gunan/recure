//
//  ToDoListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/18/25.
//

import SwiftUI

struct ToDoListView: View {
    @Binding var alerts: [Alert]
    
    var body: some View {
        NavigationStack {
            List($alerts, id: \.id) { $alert in
                ToDoItemCard(alert: alert)
                .listRowBackground(alert.reminder.theme.mainColor)
            }
            .navigationTitle("Alerts")
            .toolbar {
            }
        }
    }
}


struct ToDoListView_Previews: PreviewProvider {
    static var alerts = Alert.sampleData
    static var previews: some View {
        ToDoListView(alerts: .constant(alerts))
    }
}
