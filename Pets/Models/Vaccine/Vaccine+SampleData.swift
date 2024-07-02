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
            date: .now - (86400 * 254),
            expirationDate: .now + (86400 * 106)
        ),
        
        Vaccine(
            name: "Eclipse",
            type: .FVRCP,
            date: .now - (86400 * 450),
            expirationDate: .now - (86400 * 85)
        ),
        
        Vaccine(
            name: "VERSICAN Plus",
            type: .DHLPP,
            date: .now - (86400 * 128),
            expirationDate: .now + (86400 * 237)
        ),
        
        Vaccine(
            name: "Fel-O-Vax FIV",
            type: .FIV,
            date: .now - (86400 * 87),
            expirationDate: .now + (86400 * 278)
        ),
        
        Vaccine(
            name: "Elanco Rabies",
            type: .R,
            date: .now - (86400 * 184),
            expirationDate: .now + (86400 * 181)
        )
    ]
}
