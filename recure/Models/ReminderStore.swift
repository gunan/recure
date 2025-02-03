//
//  ReminderStore.swift
//  recure
//
//  Created by Günhan Gülsoy on 2/2/25.
//

import SwiftUI

@MainActor
class ReminderStore: ObservableObject {
    @Published var reminders: [Reminder] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("reminders.data")
    }
    
    func load() async throws {
        let task = Task<[Reminder], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let reminders = try JSONDecoder().decode([Reminder].self, from: data)
            return reminders
        }
        let reminders = try await task.value
        self.reminders = reminders
    }
    
    func save(reminders: [Reminder]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(reminders)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

