//
//  Weight+Format.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

extension Weight {
    // MARK: - computed properties
    static var formatStyle = Measurement<UnitMass>.FormatStyle(
        width: .abbreviated,
        numberFormatStyle: .number
    )
    
    static var units: String {
        if Locale.current.identifier == "en_US" {
            return "lb"
        } else {
            return "kg"
        }
    }
    
    
    // MARK: - functions
    
    /// Transform a `Double` weight value into a `Measured<UnitMass>` one.
    ///
    /// Returns a `UnitMass.kilograms` measured weigth value ready to work with.
    static func getMeasuredWeight(from value: Double) -> Measurement<UnitMass> {
        let roundedValue = round(value * 100) / 100
        
        return Measurement(value: roundedValue, unit: UnitMass.kilograms)
    }
}

