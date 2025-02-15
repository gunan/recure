//
//  AlertListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/18/25.
//

import SwiftUI

struct AlertListView: View {
    @Binding var alerts: [Alert]
    
    func removeRows(at offsets: IndexSet) {
        alerts.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($alerts, id: \.id) { $alert in
                    AlertCard(alert: alert)
                }.onDelete(perform: removeRows)
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
        AlertListView(alerts: .constant(alerts))
    }
}
