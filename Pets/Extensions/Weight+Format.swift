//
//  Weight+Format.swift
//  Pets
//
//  Created by MZiO on 30/1/25.
//

import Foundation

extension Weight {
    
    static func decimalFormatter(fractionDigits decimalNumber: Int) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = decimalNumber
        numberFormatter.minimumFractionDigits = decimalNumber
        
        return numberFormatter
    }
}
