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
    var chipID: String
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
        
        let year = dateComponents.year ?? 0
        let month = dateComponents.month ?? 0
        
        let yearString: String
        let monthString: String
        var nexus = ""
        
        switch year {
        case 0:
            yearString = ""
        case 1:
            yearString = "\(year) year"
        default:
            yearString = "\(year) years"
        }
        
        switch month {
        case 0:
            monthString = ""
        case 1:
            monthString = "\(month) month"
        default:
            monthString = "\(month) months"
        }
        
        if !yearString.isEmpty && !monthString.isEmpty {
            nexus = ", "
        }
        
        return "\(yearString)\(nexus)\(monthString) old"
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
        self.chipID = chipID
        self.birthday = birthday
        self.onFamilySince = onFamilySince
        self.isAdopted = adopted
        self.image = image
    }
    
    
    // MARK: - functions
    func getSortedWeights(in range: ClosedRange<Date>) -> [Weight] {
        weights.filter { range.contains($0.date) }.sorted { $0.date < $1.date }
    }
    
    func averageWeightIn(range: ClosedRange<Date>) -> Double {
        let weightsInRange = weights.filter { range.contains($0.date) }
        var totalWeightValue: Double = 0
        
        for weight in weightsInRange {
            totalWeightValue += weight.value
        }
        
        return totalWeightValue / Double(weightsInRange.count)
    }
}


// MARK: - sample data
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
