//
//  ToDoListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/18/25.
//

import SwiftUI

struct ToDoListView: View {
    @Binding var alerts: [Alert]
    
    func removeRows(at offsets: IndexSet) {
        alerts.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($alerts, id: \.id) { $alert in
                    ToDoItemCard(alert: alert)
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
        ToDoListView(alerts: .constant(alerts))
    }
}
