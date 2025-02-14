//
//  ReminderCard.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/1/25.
//

import SwiftUI

struct ReminderCard: View {
    let reminder: Reminder
    var body: some View {
        VStack(alignment: .leading) {
            Text(reminder.title).font(.title)
            HStack() {
                Label("\(reminder.startDate, format: .dateTime.month().day())", systemImage: "timer")
                Spacer()
                Label("\(reminder.nextAlertDate, format: .dateTime.month().day())", systemImage: "bell").padding(.trailing, 20)
                
            }.font(.caption)
            Text(reminder.description)
        }
        .padding()
        .foregroundColor(reminder.theme.accentColor)
    }
}


struct ReminderCard_Previews: PreviewProvider {
    static var reminder = Reminder.sampleData[0]
    static var previews: some View {
        ReminderCard(reminder: reminder)
            // .background(reminder.theme.mainColor)
            .background(reminder.theme.mainColor)
    }
}
