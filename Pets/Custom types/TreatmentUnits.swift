//
//  TreatmentUnits.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum TreatmentUnits: String, Codable, CaseIterable {
    case unknown
    case milligrams = "mg"
    case milligramsPerMilliliter = "mg/ml"
    case milligramsPerKilogram = "mg/kg"
    case milliliters = "ml"
    case millilitersPerKilogram = "ml/kg"
    case units
    case markings
    case partsPerMillion = "ppm"
}
