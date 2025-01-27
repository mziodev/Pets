//
//  CoatTexture.swift
//  Pets
//
//  Created by MZiO on 24/8/24.
//

import Foundation

enum CoatTexture: CaseIterable, Codable {
    case silky
    case medium
    case thick
    case wiry
    case crinkled
    
    var name: String {
        switch self {
        case .silky:
            String(localized: "Silky")
        case .medium:
            String(localized: "Medium")
        case .thick:
            String(localized: "Thick")
        case .wiry:
            String(localized: "Wiry")
        case .crinkled:
            String(localized: "Crinkle")
        }
    }
    
    var description: String {
        switch self {
        case .silky:
            String(localized: "Soft and smooth to the touch")
        case .medium:
            String(localized: "Straight and smooth, but not as fine as fine coats")
        case .thick:
            String(localized: "Thick and rough, with a dense undercoat")
        case .wiry:
            String(localized: "Harsh and wiry, with a dense undercoat")
        case .crinkled:
            String(localized: "Forms a wavy or crinkled texture")
        }
    }
}
