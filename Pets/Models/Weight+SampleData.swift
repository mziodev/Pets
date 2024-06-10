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
