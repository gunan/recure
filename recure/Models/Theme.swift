//
//  Theme.swift
//  recure
//
//  Created by Gunhan Gulsoy on 12/22/24.
//

import SwiftUI


enum Theme: String, Codable {
    case blue
    case red
    case green
    case yellow
    case brown
    case cyan
    case indigo
    case mint
    case orange
    case pink
    case teal
    case purple
    
    
    var mainColor: Color {
        switch self {
        case .blue:
            return Color.blue
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .brown:
            return Color.brown
        case .cyan:
            return Color.cyan
        case .indigo:
            return Color.indigo
        case .mint:
            return Color.mint
        case .orange:
            return Color.orange
        case .pink:
            return Color.pink
        case .teal:
            return Color.teal
        case .purple:
            return Color.purple
        }
    }
    
    var accentColor: Color {
        switch self {
        case .blue, .red, .orange, .teal, .yellow, .green, .cyan, .mint, .pink: return Color.black
        case .indigo, .purple, .brown: return .white
        }
    }
}
