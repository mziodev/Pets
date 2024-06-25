//
//  TreatmentUnits.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum TreatmentUnits: String, Codable, CaseIterable {
    case markings
    case milligrams = "mg"
    case milligramsPerMilliliter = "mg/ml"
    case milligramsPerKilogram = "mg/kg"
    case milliliters = "ml"
    case millilitersPerKilogram = "ml/kg"
    case partsPerMillion = "ppm"
    case units
}
