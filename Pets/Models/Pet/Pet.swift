//
//  Pet.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import Foundation
import SwiftData

@Model
class Pet: ObservableObject {
    var species: PetSpecies
    var sex: PetSex
    var name: String
    var breed: String
    var chipIDType: ChipIDType
    var chipID: String
    var isAdopted: Bool
    var birthday: Date
    var onFamilySince: Date
    
    @Attribute(.externalStorage)
    var image: Data?
    
    @Relationship(deleteRule: .cascade)
    var weights = [Weight]()
    
    @Relationship(deleteRule: .cascade)
    var dewormings = [DewormingTreatment]()
    
    init(
        species: PetSpecies = .unknown,
        sex: PetSex = .unknown,
        name: String = "",
        breed: String = "",
        chipIDType: ChipIDType = .noChipID,
        chipID: String = "",
        adopted: Bool = false,
        birthday: Date = .now,
        onFamilySince: Date = .now,
        image: Data? = nil
    ) {
        self.species = species
        self.sex = sex
        self.name = name
        self.breed = breed
        self.chipIDType = chipIDType
        self.chipID = chipID
        self.birthday = birthday
        self.onFamilySince = onFamilySince
        self.isAdopted = adopted
        self.image = image
    }
    
    /// Computed property that calculates the age in years and months based on the pet `birthday` date.
    ///
    /// - returns: An array with two strings: the first represents the years, and the second represents the months.
    ///
    /// - Note: This property assumes `birthday` is a valid date in the past.
    var age: [String] {
        let dateComponents = Calendar.current.dateComponents([.year, .month], from: birthday, to: Date.now)
        
        let year = dateComponents.year ?? 0
        let month = dateComponents.month ?? 0
        
        var age: [String] = []
        
        switch year {
        case 0: 
            age.append("")
        case 1: 
            age.append("1 year")
        default: 
            age.append("\(year) years")
        }

        switch month {
        case 0:
            year > 0 ? age.append("") : age.append("Newborn 🐣")
        case 1: 
            age.append("1 month")
        default: 
            age.append("\(month) months")
        }

        return age
    }
}
