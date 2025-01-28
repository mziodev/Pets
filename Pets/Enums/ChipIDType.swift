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
    
    var localizedDescription: String {
        switch self {
        case .noChipID:
            String(localized: "No chip")
        case .nineDigit:
            String(localized: "9-digits (AVID)")
        case .tenDigit:
            String(localized: "10-digit (ISO)")
        case .fifteenDigit:
            String(localized: "15-digit (ISO)")
        }
    }
    
    var placeholderText: String {
        switch self {
        case .noChipID:
            ""
        case .nineDigit:
            String(localized: "ID number (9 numeric digits)")
        case .tenDigit:
            String(localized: "ID number (10 alphanumeric digits)")
        case .fifteenDigit:
            String(localized: "ID number (15 numeric digits)")
        }
    }
}
