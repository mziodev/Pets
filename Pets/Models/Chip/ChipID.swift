//
//  ChipID.swift
//  Pets
//
//  Created by MZiO on 1/7/24.
//

import Foundation

struct ChipID: Codable {
    var type: ChipIDType
    var number: String
    var implantedDate: Date
    var location: String
    
    init(
        type: ChipIDType = .noChipID,
        number: String = "",
        implantedDate: Date = .now,
        location: String = ""
    ) {
        self.type = type
        self.number = number
        self.implantedDate = implantedDate
        self.location = location
    }
}
