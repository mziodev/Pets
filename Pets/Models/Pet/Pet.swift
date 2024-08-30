//
//  Pet.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import Foundation
import SwiftData

@Model
class Pet: Equatable, ObservableObject {
    var species: PetSpecies = PetSpecies.unknown
    var sex: PetSex = PetSex.unknown
    var name: String = ""
    var breed: String = ""
    var chipID: ChipID = ChipID()
    var isAdopted: Bool = false
    var birthday: Date = Date.now
    var onFamilySince: Date = Date.now
    
    @Attribute(.externalStorage)
    var image: Data?
    
    @Relationship(deleteRule: .cascade)
    var weights: [Weight]? = [Weight]()
    
    @Relationship(deleteRule: .cascade)
    var dewormingTreatments: [DewormingTreatment]? = [DewormingTreatment]()
    
    @Relationship(deleteRule: .cascade)
    var vaccines: [Vaccine]? = [Vaccine]()
    
    var unwrappedWeights: [Weight] {
        weights ?? []
    }
    
    var unwrappedDewormingTreatments: [DewormingTreatment] {
        dewormingTreatments ?? []
    }
    
    var unwrappedVaccines: [Vaccine] {
        vaccines ?? []
    }
    
    init(
        species: PetSpecies = .unknown,
        sex: PetSex = .unknown,
        name: String = "",
        breed: String = "",
        chipID: ChipID = ChipID(),
        adopted: Bool = false,
        birthday: Date = .now,
        onFamilySince: Date = .now,
        image: Data? = nil
    ) {
        self.species = species
        self.sex = sex
        self.name = name
        self.breed = breed
        self.chipID = chipID
        self.birthday = birthday
        self.onFamilySince = onFamilySince
        self.isAdopted = adopted
        self.image = image
    }
    
    var age: [String: String] {
        years(from: birthday)
    }
    
    var onFamilyYears: [String: String] {
        years(from: onFamilySince)
    }
    
    /// Calculates the years, months and days until a date.
    ///
    /// - returns: An array with up to three strings: the first one representing the years, the second one representing the months,
    /// and the third one (only if the last two are zero) representing the days,
    ///
    /// - Note: This property assumes `date` is a valid date in the past.
    private func years(from date: Date) -> [String: String] {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date, to: .now)
        
        let year = dateComponents.year ?? 0
        let month = dateComponents.month ?? 0
        let day = dateComponents.day ?? 0
        
        var age: [String: String] = [:]
        
        if year > 0 { age["year"] = String(localized: "\(year) years") }
        
        if month > 0 {
            age["month"] = year > 0 ? String(localized: "& \(month) months") : String(localized: "\(month) months")
        }
        
        if year == 0 && month == 0 { age["day"] = String(localized: "\(day) days") }

        return age
    }
}
