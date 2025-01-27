//
//  TreatmentUnit.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum TreatmentUnit: String, Codable, CaseIterable {
    case markings
    case milligrams
    case milligramsPerMilliliter
    case milligramsPerKilogram
    case milliliters
    case millilitersPerKilogram
    case partsPerMillion
    case units
    
    var localizedDescription: String {
        switch self {
        case .markings:
            String(localized: "Markings")
        case .milligrams:
            String(localized: "mg")
        case .milligramsPerMilliliter:
            String(localized: "mg/ml")
        case .milligramsPerKilogram:
            String(localized: "mg/kg")
        case .milliliters:
            String(localized: "ml")
        case .millilitersPerKilogram:
            String(localized: "ml/kg")
        case .partsPerMillion:
            String(localized: "ppm")
        case .units:
            String(localized: "Units")
        }
    }
}
