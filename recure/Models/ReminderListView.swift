//
//  ReminderListView.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/1/25.
//

import SwiftUI

struct ReminderListView: View {
    let reminder: Reminder
    var body: some View {
        VStack(alignment: .leading) {
            Text(reminder.title).font(.title)
            HStack() {
                Label("\(reminder.alertDate, format: .dateTime.month().day())", systemImage: "timer")
                Spacer()
                Label("\(reminder.dueDate, format: .dateTime.month().day())", systemImage: "bell").padding(.trailing, 20)
                
            }.font(.caption)
            Text(reminder.description)
        }.padding()
    }
}


struct ReminderListView_Previews: PreviewProvider {
    static var reminder = Reminder.sampleData[0]
    static var previews: some View {
        ReminderListView(reminder: reminder).background(.blue).previewLayout(.fixed(width: 400, height: 60))
    }
}
