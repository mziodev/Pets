//
//  CanineVaccine.swift
//  Pets
//
//  Created by MZiO on 27/6/24.
//

import Foundation
import SwiftData

@Model
class CanineVaccine {
    var name: String
    var typeCode: CanineVaccineType
    var date: Date
    var expirationDate: Date
    var pet: Pet?
    
    init(
        name: String = "",
        typeCode: CanineVaccineType,
        date: Date = .now,
        expirationDate: Date = .now,
        pet: Pet? = nil
    ) {
        self.name = name
        self.typeCode = typeCode
        self.date = date
        self.expirationDate = expirationDate
        self.pet = pet
    }
}
