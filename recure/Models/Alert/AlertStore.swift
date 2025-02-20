//
//  AlertStore.swift
//  recure
//
//  Created by Günhan Gülsoy on 2/2/25.
//

import SwiftUI

@MainActor
class AlertStore: ObservableObject {
    @Published var alerts: [Alert] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("alerts.data")
    }
    
    func load() async throws {
        let task = Task<[Alert], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let alerts = try JSONDecoder().decode([Alert].self, from: data)
            return alerts
        }
        let alerts = try await task.value
        self.alerts = alerts
    }
    
    func save(alerts: [Alert]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(alerts)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    public func refresh() {
        for var alert in self.alerts where !alert.isVisible {
            if alert.alertDate > Date.now {
                alert.isVisible = true
            }
        }
    }
}

