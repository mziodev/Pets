//
//  Array+Weight.swift
//  Pets
//
//  Created by MZiO on 28/8/24.
//

import Foundation

extension Array where Element == Weight {
    var sortedByDate: [Weight] {
        self.sorted { $0.date < $1.date }
    }
    
    var reverseSortedByDate: [Weight] {
        self.sorted { $0.date > $1.date }
    }
    
    var currentWeight: Double {
        self.reverseSortedByDate.first?.value ?? 0
    }
    
    func filteringAndSorting(in range: ClosedRange<Date>) -> [Weight] {
        self.filter { range.contains($0.date) }.sortedByDate
    }
    
    func averaging() -> Double {
        self.reduce(0, { $0 + $1.value }) / Double(count)
    }
    
    func gettingAverage(in range: ClosedRange<Date>) -> Double {
        let weightsInRange = self.filter { range.contains($0.date) }
        
        return weightsInRange.isEmpty ? 0 : weightsInRange.map { $0.value }.reduce(0, +) / Double(weightsInRange.count)
    }
}
