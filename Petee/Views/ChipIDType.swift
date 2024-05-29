//
//  ChipIDType.swift
//  Petee
//
//  Created by MZiO on 29/5/24.
//

import Foundation

enum ChipIDType: String, CaseIterable {
    case fifteenDigits = "15 digits (ISO/European)"
    case nineDigits = "9 digits (AVID)"
    
    var id: Self { self }
}
