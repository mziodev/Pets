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
    var dewormingTreatments = [DewormingTreatment]()
    
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
        
        switch year {
        case 0:
            break
        case 1:
            age["year"] = "1 year"
        default:
            age["year"] = "\(year) years"
        }

        switch month {
        case 0:
            break
        case 1:
            age["month"] = year > 0 ? "& 1 month" : "1 month"
        default:
            age["month"] = year > 0 ? "& \(month) months" : "\(month) months"
        }
        
        if year == 0 && month == 0 {
            switch day {
            case 1:
                age["day"] = "1 day"
            default:
                age["day"] = "\(day) days"
            }
        }

        return age
    }
}
