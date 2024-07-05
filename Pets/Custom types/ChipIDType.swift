//
//  ChipIDType.swift
//  Pets
//
//  Created by MZiO on 29/5/24.
//

import Foundation

enum ChipIDType: String, Codable, CaseIterable {
    case noChipID
    case fifteenDigit
    case tenDigit
    case nineDigit
    
    var description: String {
        switch self {
        case .noChipID:
            String(localized: "No chip")
        case .fifteenDigit:
            String(localized: "15-digit (ISO)")
        case .tenDigit:
            String(localized: "10-digit (ISO)")
        case .nineDigit:
            String(localized: "9-digits (AVID)")
        }
    }
}
