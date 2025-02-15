//
//  AlertCard.swift
//  recure
//
//  Created by Günhan Gülsoy on 1/17/25.
//

import SwiftUI

struct AlertCard: View {
    let alert: Alert
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("Triggered at: \(alert.reminder.nextAlertDate, format:.dateTime.day().month().hour().minute())")
                    .font(.caption)
                Spacer()
            }
            Text(alert.reminder.title).font(.title)
            Text(alert.reminder.description)
        }
        .padding()
        .foregroundColor(alert.reminder.theme.accentColor)
    }
}


struct AlertCard_Previews: PreviewProvider {
    static var alert = Alert.sampleData[0]
    static var previews: some View {
        AlertCard(alert: alert)
            // .background(reminder.theme.mainColor)
            .background(alert.reminder.theme.mainColor)
    }
}

