//
//  Pet.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import Foundation
import SwiftData

@Model
class Pet {
    // MARK: - properties
    let type: PetSpecies
    let sex: PetSex
    var name: String
    var birthday: Date
    var breed: String
    var image: Data?
    var adopted: Bool
    var onFamilySince: Date
    var weights = [Weight]()
    
    
    // MARK: - computed properties
    var age: String {
        let components = Calendar.current.dateComponents(
            [.year, .month],
            from: birthday,
            to: Date.now
        )
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let completeAge: String
        
        
        if years > 0 && months > 0 {
            if years == 1 && months == 1 {
                completeAge = "\(years) year and \(months) month old"
            } else if years == 1 {
                completeAge = "\(years) year and \(months) months old"
            } else if months == 1 {
                completeAge = "\(years) years and \(months) month old"
            } else {
                completeAge = "\(years) years and \(months) months old"
            }
        } else if years > 0 && months == 0 {
            if years == 1 {
                completeAge = "\(years) year old"
            } else {
                completeAge = "\(years) years old"
            }
        } else {
            if months == 1 {
                completeAge = "\(months) month old"
            } else {
                completeAge = "\(months) months old"
            }
        }
        
        return completeAge
    }
    
    var sortedWeights: [Weight] {
        weights.sorted { $0.date > $1.date }
    }
    
    
    // MARK: - class init
    init(
        type: PetSpecies,
        sex: PetSex,
        name: String,
        birthday: Date,
        breed: String,
        adopted: Bool,
        onFamilySince: Date
    ) {
        self.type = type
        self.sex = sex
        self.name = name
        self.birthday = birthday
        self.breed = breed
        self.adopted = adopted
        self.onFamilySince = onFamilySince
    }
    
    
    // MARK: - functions
    func getSortedWeights(in range: ClosedRange<Date>) -> [Weight] {
        sortedWeights.filter { range.contains($0.date) }
    }
}


// MARK: - custom data types extension
extension Pet {
    enum PetSpecies: String, CaseIterable, Codable {
        case canine = "dog"
        case feline = "cat"
    }
    
    enum PetSex: String, CaseIterable, Codable {
        case male = "male"
        case female = "female"
    }
}


// MARK: - sample data extension
extension Pet {
    static let sampleData = [
        Pet(
            type: .canine,
            sex: .male,
            name: "Rocky",
            birthday: .now - (86400 * 500),
            breed: "Jack Russell",
            adopted: true,
            onFamilySince: .now - (86400 * 5)
        ),
        Pet(
            type: .canine,
            sex: .male,
            name: "Tom",
            birthday: .now - (86400 * 370),
            breed: "Puddle",
            adopted: false,
            onFamilySince: .now - (86400 * 50)
        ),
        Pet(
            type: .feline,
            sex: .female,
            name: "Lia",
            birthday: .now - (86400 * 30),
            breed: "Sphinx",
            adopted: false,
            onFamilySince: .now - (86400 * 5)
        ),
    ]
}
