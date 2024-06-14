//
//  Weight+Utilities.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

extension Array where Element == Weight {
    
    /// Function that calculates the average weight of the elements in the array.
    ///
    /// - returns: The average weight value
    func averaging() -> Double {
        reduce(0, { $0 + $1.value }) / Double(count)
    }
}
