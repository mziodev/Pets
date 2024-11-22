//
//  DewormingType.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum TreatmentType: Codable, CaseIterable {
    case unknown
    case pill
    case liquid
    case pipette
    case spray
    case shampoo
    case collar
    case injection
    case additive
    case suppository
    case others
    
    var systemImage: String {
        switch self {
        case .unknown:
            "ant"
        case .pill:
            "pills"
        case .liquid:
            "cross.vial"
        case .pipette:
            "testtube.2"
        case .spray:
            "humidifier.and.droplets"
        case .shampoo:
            "bubbles.and.sparkles"
        case .collar:
            "circle"
        case .injection:
            "syringe"
        case .additive:
            "waterbottle"
        case .suppository:
            "pill"
        case .others:
            "ivfluid.bag"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            String(localized: "Unknown")
        case .pill:
            String(localized: "Pill")
        case .liquid:
            String(localized: "Liquid")
        case .pipette:
            String(localized: "Pipette")
        case .spray:
            String(localized: "Spray")
        case .shampoo:
            String(localized: "Shampoo")
        case .collar:
            String(localized: "Collar")
        case .injection:
            String(localized: "Injection")
        case .additive:
            String(localized: "Additive")
        case .suppository:
            String(localized: "Suppository")
        case .others:
            String(localized: "Others")
        }
    }
}
