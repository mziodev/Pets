//
//  Deworming.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation
import SwiftData

@Model
class Deworming {
    var type: DewormingType
    var units: TreatmentUnits
    var treatmentName: String
    var quantity: Int
    var date: Date
    var expirationDate: Date
    var notes: String
    var pet: Pet?
    
    var remainingTreatmentDays: Int {
        Int(expirationDate.timeIntervalSince(.now) / 86400)
    }
    
    init(
        type: DewormingType = .unknown,
        units: TreatmentUnits = .unknown,
        treatmentName: String = "",
        quantity: Int = 0,
        date: Date = .now,
        expirationDate: Date = .now,
        notes: String = ""
    ) {
        self.type = type
        self.units = units
        self.treatmentName = treatmentName
        self.quantity = quantity
        self.date = date
        self.expirationDate = expirationDate
        self.notes = notes
        self.pet = pet
    }
}
