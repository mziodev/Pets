//
//  Weight+Format.swift
//  Pets
//
//  Created by MZiO on 21/11/24.
//

import Foundation

extension Weight {
    static var units: String {
        Locale.current.identifier == "en_US" ? "lb" : "kg"
    }
    
    static func decimalFormatter(for decimalNumber: Int) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = decimalNumber
        numberFormatter.minimumFractionDigits = decimalNumber
        
        return numberFormatter
    }
}
