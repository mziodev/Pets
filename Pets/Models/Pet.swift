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
    var chipIDType: ChipIDType
    var chipID: String
    var isAdopted: Bool
    var birthday: Date
    var onFamilySince: Date
    
    @Attribute(.externalStorage)
    var image: Data?
    
    @Relationship(deleteRule: .cascade)
    var weights = [Weight]()
    
    
    // MARK: - init
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
    
    
    // MARK: - computed properties
    
    /// Calculates the age in years and months based on the pet `birthday` date.
    ///
    /// Returns an array of two strings: the first represents the years, and the second represents the months.
    ///
    /// - Note: This property assumes `birthday` is a valid date in the past.
    var age: [String] {
        let dateComponents = Calendar.current.dateComponents([.year, .month], from: birthday, to: Date.now)
        
        let year = dateComponents.year ?? 0
        let month = dateComponents.month ?? 0

        let formatString: (Int) -> String = { count in
            switch count {
            case 0: return ""
            case 1: return "\(count) \(count == 1 ? "year" : "month")"
            default: return "\(count) \(count == 1 ? "years" : "months")"
            }
        }

        return [formatString(year), formatString(month)]
    }
    
    var sortedWeights: [Weight] {
        weights.sorted { $0.date < $1.date }
    }
    
    var reverseSortedWeights: [Weight] {
        weights.sorted { $0.date > $1.date }
    }
    
    
    // MARK: - functions
    
    /// Sorts and filters the weights within a given date range.
    ///
    /// - Parameter range: A closed range of dates to filter the weights by.
    ///
    /// - Returns: An array of weights filtered by date and sorted in ascending order.
    ///
    /// - Note: This function assumes that the `weights` array is already populated with `Weight` objects.
    func filteringAndSortWeights(in range: ClosedRange<Date>) -> [Weight] {
        weights.filter { range.contains($0.date) }.sorted { $0.date < $1.date }
    }
    
    /// Calculates the average weight of a range of dates.
    ///
    /// - parameter range: A closed range of dates for which to calculate the average weight.
    ///
    /// - returns: The average weight for the specified date range.
    ///
    /// - note: If no weights are found in the specified range, the function returns 0.
    func getAverageWeight(in range: ClosedRange<Date>) -> Double {
        let weightsInRange = weights.filter { range.contains($0.date) }
        
        return weightsInRange.isEmpty ? 0 : weightsInRange.map { $0.value }.reduce(0, +) / Double(weightsInRange.count)
    }
}
