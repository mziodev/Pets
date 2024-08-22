//
//  Vaccine.swift
//  Pets
//
//  Created by MZiO on 27/6/24.
//

import Foundation
import SwiftData

@Model
class Vaccine {
    var name: String
    var type: VaccineType
    var starts: Date
    var ends: Date
    var pet: Pet?
    
    var activeDays: Int {
        Int(ends.timeIntervalSince(.now) / 86400)
    }
    
    init(
        name: String = "",
        type: VaccineType = .unknown,
        starts: Date = .now,
        ends: Date = .now,
        pet: Pet? = nil
    ) {
        self.name = name
        self.type = type
        self.starts = starts
        self.ends = ends
        self.pet = pet
    }
}
