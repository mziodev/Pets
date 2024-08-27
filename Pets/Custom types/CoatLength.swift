//
//  CoatLength.swift
//  Pets
//
//  Created by MZiO on 23/8/24.
//

import Foundation

enum CoatLength: CaseIterable, Codable {
    case hairless
    case buzzed
    case fluffy
    case short
    case medium
    case long
    case flowing
    
    var name: String {
        switch self {
        case .hairless:
            String(localized: "Hairless")
        case .buzzed:
            String(localized: "Buzzed")
        case .fluffy:
            String(localized: "Fine downy coat")
        case .short:
            String(localized: "Short")
        case .medium:
            String(localized: "Medium")
        case .long:
            String(localized: "Long")
        case .flowing:
            String(localized: "Extra Long")
        }
    }
    
    var description: String {
        switch self {
        case .hairless:
            String(localized: "None (completely hairless)")
        case .buzzed:
            String(localized: "Very short (less than 1/4 inch or 6 mm)")
        case .fluffy:
            String(localized: "Fine downy coat (about 1/4 inch or 6 mm)")
        case .short:
            String(localized: "Less than 1 inch (2.5 cm)")
        case .medium:
            String(localized: "About 1-3 inches (2.5-7.5 cm)")
        case .long:
            String(localized: "About 3-6 inches (7.5-15 cm)")
        case .flowing:
            String(localized: "More than 6 inches (15 cm)")
        }
    }
}
