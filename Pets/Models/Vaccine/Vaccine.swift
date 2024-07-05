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
    var date: Date
    var expirationDate: Date
    var pet: Pet?
    
    var activeDays: Int {
        Int(expirationDate.timeIntervalSince(.now) / 86400)
    }
    
    init(
        name: String = "",
        type: VaccineType = .unknown,
        date: Date = .now,
        expirationDate: Date = .now,
        pet: Pet? = nil
    ) {
        self.name = name
        self.type = type
        self.date = date
        self.expirationDate = expirationDate
        self.pet = pet
    }
}
