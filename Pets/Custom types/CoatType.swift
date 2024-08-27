//
//  CoatType.swift
//  Pets
//
//  Created by MZiO on 23/8/24.
//

import Foundation

enum CoatType: CaseIterable, Codable {
    case straight
    case curly
    case wavy
    case corded
    case double
    
    var name: String {
        switch self {
        case .straight:
            String(localized: "Straight")
        case .curly:
            String(localized: "Curly")
        case .wavy:
            String(localized: "Wavy")
        case .corded:
            String(localized: "Corded")
        case .double:
            String(localized: "Double")
        }
    }
    
    var description: String {
        switch self {
        case .straight:
            String(localized: "Lies flat against the body, with no curl or wave")
        case .curly:
            String(localized: "Forms tight curls or waves")
        case .wavy:
            String(localized: "Forms loose waves or ripples")
        case .corded:
            String(localized: "Forms long, thin cords or mats")
        case .double:
            String(localized: "Has two distinct layers of fur, with a soft undercoat and a coarser outer coat")
        }
    }
}
