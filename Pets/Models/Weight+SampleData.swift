//
//  Weight+SampleData.swift
//  Pets
//
//  Created by MZiO on 8/6/24.
//

import Foundation

extension Weight {
    
    static let sampleData = [
        // Rocky
        Weight(date: .now - (86400 * 2), value: 7.340),
        Weight(date: .now - (86400 * 25), value: 7.150),
        Weight(date: .now - (86400 * 60), value: 6.950),
        
        // Tom
        Weight(date: .now - (86400 * 5), value: 3.250),
        Weight(date: .now - (86400 * 24), value: 3.300),
        Weight(date: .now - (86400 * 52), value: 3.150),
        Weight(date: .now - (86400 * 190), value: 3.025),

        // Lia
        Weight(date: .now - (86400 * 3), value: 1.280),
        Weight(date: .now - (86400 * 25), value: 1.050),
    ]
}
