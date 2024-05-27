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
    var species: PetSpecies
    var sex: PetSex
    var name: String
    var breed: String
    var isAdopted: Bool
    var birthday: Date
    var onFamilySince: Date
    
    @Attribute(.externalStorage)
    var image: Data?
    
    @Relationship(deleteRule: .cascade)
    var weights = [Weight]()
    
    
    // MARK: - computed properties
    var age: String {
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month],
            from: birthday,
            to: Date.now
        )
        
        let years = dateComponents.year ?? 0
        let months = dateComponents.month ?? 0
        
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
        weights.sorted { $0.date < $1.date }
    }
    
    var reverseSortedWeights: [Weight] {
        weights.sorted { $0.date > $1.date }
    }
    
    
    // MARK: - class init
    init(
        species: PetSpecies = .canine,
        sex: PetSex = .female,
        name: String = "",
        breed: String = "",
        adopted: Bool = false,
        birthday: Date = .now,
        onFamilySince: Date = .now,
        image: Data? = nil
    ) {
        self.species = species
        self.sex = sex
        self.name = name
        self.breed = breed
        self.birthday = birthday
        self.onFamilySince = onFamilySince
        self.isAdopted = adopted
        self.image = image
    }
    
    
    // MARK: - functions
    func getSortedWeights(in range: ClosedRange<Date>) -> [Weight] {
        weights.filter { range.contains($0.date) }.sorted { $0.date < $1.date }
    }
    
    func averageWeightIn(range: ClosedRange<Date>) -> Float {
        let weightsInRange = weights.filter { range.contains($0.date) }
        var totalWeightValue: Float = 0
        
        for weight in weightsInRange {
            totalWeightValue += weight.value
        }
        
        return totalWeightValue / Float(weightsInRange.count)
    }
}


// MARK: - sample data extension
extension Pet {
    static let sampleData = [
        Pet(
            species: .canine,
            sex: .male,
            name: "Rocky",
            breed: "Jack Russell",
            adopted: true,
            birthday: .now - (86400 * 500),
            onFamilySince: .now - (86400 * 5)
        ),
        
        Pet(
            species: .canine,
            sex: .male,
            name: "Tom",
            breed: "Puddle",
            adopted: false,
            birthday: .now - (86400 * 370),
            onFamilySince: .now - (86400 * 50)
        ),
        
        Pet(
            species: .feline,
            sex: .female,
            name: "Lia",
            breed: "Sphinx",
            adopted: false,
            birthday: .now - (86400 * 30),
            onFamilySince: .now - (86400 * 5)
        ),
    ]
}
