//
//  PetSize.swift
//  Pets
//
//  Created by MZiO on 23/8/24.
//

import Foundation

enum PetSize: CaseIterable, Codable {
    case toy
    case mini
    case small
    case medium
    case large
    case extra
    case giant
    
    var name: String {
        switch self {
        case .toy:
            String(localized: "Toy")
        case .mini:
            String(localized: "Miniature")
        case .small:
            String(localized: "Small")
        case .medium:
            String(localized: "Medium")
        case .large:
            String(localized: "Large")
        case .extra:
            String(localized: "Extra Large")
        case .giant:
            String(localized: "Giant")
        }
    }
    
    var dogDescription: String {
        switch self {
        case .toy:
            String(localized: "Under 10 pounds (4.5 kg)")
        case .mini:
            String(localized: "10-20 pounds (4.5-9 kg)")
        case .small:
            String(localized: "20-30 pounds (9-13.6 kg)")
        case .medium:
            String(localized: "30-50 pounds (13.6-22.7 kg)")
        case .large:
            String(localized: "50-80 pounds (22.7-36 kg)")
        case .extra:
            String(localized: "80-100 pounds (36-45 kg)")
        case .giant:
            String(localized: "over 100 pounds (45 kg)")
        }
    }
    
    var catDescription: String {
        switch self {
        case .toy:
            String(localized: "under 4 pounds (1.8 kg)")
        case .mini:
            String(localized: "4-8 pounds (1.8-3.6 kg)")
        case .small:
            String(localized: "8-12 pounds (3.6-5.4 kg)")
        case .medium:
            String(localized: "12-15 pounds (5.4-6.8 kg)")
        case .large:
            String(localized: "15-18 pounds (6.8-8.2 kg)")
        case .extra:
            String(localized: "18-22 pounds (8.2-10 kg)")
        case .giant:
            String(localized: "over 22 pounds (10 kg)")
        }
    }
}
