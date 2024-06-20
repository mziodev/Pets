//
//  Pet+Sorting.swift
//  Pets
//
//  Created by MZiO on 17/6/24.
//

import Foundation

extension Pet {
    var sortedWeights: [Weight] {
        weights.sorted { $0.date < $1.date }
    }
    
    var reverseSortedWeights: [Weight] {
        weights.sorted { $0.date > $1.date }
    }
    
    func filteringAndSortingWeights(in range: ClosedRange<Date>) -> [Weight] {
        weights.filter { range.contains($0.date) }.sorted { $0.date < $1.date }
    }
    
    func getAverageWeight(in range: ClosedRange<Date>) -> Double {
        let weightsInRange = weights.filter { range.contains($0.date) }
        
        return weightsInRange.isEmpty ? 0 : weightsInRange.map { $0.value }.reduce(0, +) / Double(weightsInRange.count)
    }
}
