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
    var date: Date
    var value: Double
    var pet: Pet?
    
    
    // MARK: - init
    init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }
    
    static func getMeasuredValue(from value: Double) -> Measurement<UnitMass> {
        Measurement(value: value, unit: UnitMass.kilograms)
    }
}

extension Weight {
    static let sampleData = [
        // Rocky
        Weight(date: .now - (86400 * 60), value: 6.950),
        Weight(date: .now - (86400 * 25), value: 7.150),
        Weight(date: .now, value: 7.340),
        
        // Tom
        Weight(date: .now - (86400 * 190), value: 3.025),
        Weight(date: .now - (86400 * 52), value: 3.150),
        Weight(date: .now - (86400 * 24), value: 3.300),
        Weight(date: .now - (86400 * 5), value: 3.250),

        // Lia
        Weight(date: .now - (86400 * 5), value: 1.050),
        Weight(date: .now, value: 1.280),
    ]
}
