//
//  Array+DewormingTreatment.swift
//  Pets
//
//  Created by MZiO on 28/8/24.
//

import Foundation

extension Array where Element == DewormingTreatment {
    var reverseSortedByActiveDays: [DewormingTreatment] {
        self.sorted { $0.activeDays > $1.activeDays }
    }
    
    var active: Int {
        self.filter { $0.activeDays >= 0 }.count
    }
    
    var expired: Int {
        self.filter { $0.activeDays < 0 }.count
    }
    
    var lastActive: DewormingTreatment? {
        self.first(where: { $0.activeDays >= 0 })
    }
    
    var nextToExpire: DewormingTreatment? {
        self.filter { $0.activeDays >= 0 }.min { $0.activeDays < $1.activeDays }
    }
}
