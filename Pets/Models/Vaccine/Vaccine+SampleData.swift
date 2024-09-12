//
//  Vaccine+SampleData.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import Foundation

extension Vaccine {
    static let sampleData = [
        Vaccine(
            name: "Nobivac",
            type: .DHLPPi,
            starts: .now - (86400 * 254),
            ends: .now + (86400 * 106)
        ),
        
        Vaccine(
            name: "Eclipse",
            type: .FVRCP,
            starts: .now - (86400 * 450),
            ends: .now - (86400 * 86)
        ),
        
        Vaccine(
            name: "VERSICAN Plus",
            type: .DHLPP,
            starts: .now - (86400 * 128),
            ends: .now + (86400 * 237)
        ),
        
        Vaccine(
            name: "Fel-O-Vax FIV",
            type: .FIV,
            starts: .now - (86400 * 87),
            ends: .now + (86400 * 278)
        ),
        
        Vaccine(
            name: "Elanco Rabies",
            type: .R,
            starts: .now - (86400 * 184),
            ends: .now + (86400 * 181)
        )
    ]
}
