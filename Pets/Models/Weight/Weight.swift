//
//  Weight.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

import Foundation
import SwiftData

@Model
class Weight {
    var date: Date = Date.now
    var value: Double = 0
    var pet: Pet?
    var notes: String = ""
    
    static var units: String {
        Locale.current.identifier == "en_US" ? "lb" : "kg"
    }
    
    init(date: Date = .now, value: Double = 0) {
        self.date = date
        self.value = value
    }
    
    static func decimalFormatter(for decimalNumber: Int) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = decimalNumber
        numberFormatter.minimumFractionDigits = decimalNumber
        
        return numberFormatter
    }
}
