//
//  ChipIDType.swift
//  Pets
//
//  Created by MZiO on 29/5/24.
//

import Foundation

enum ChipIDType: String, Codable, CaseIterable {
    case noChipID = "No chip"
    case fifteenDigits = "15 digits (ISO/Euro)"
    case nineDigits = "9 digits (AVID)"
}
