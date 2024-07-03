//
//  ChipIDType.swift
//  Pets
//
//  Created by MZiO on 29/5/24.
//

import Foundation

enum ChipIDType: String, Codable, CaseIterable {
    case noChipID = "No chip"
    case fifteenDigit = "15-digit (ISO)"
    case tenDigit = "10-digit (ISO)"
    case nineDigit = "9-digits (AVID)"
}
