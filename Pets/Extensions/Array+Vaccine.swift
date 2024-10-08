//
//  Array+Vaccine.swift
//  Pets
//
//  Created by MZiO on 28/8/24.
//

import Foundation

extension Array where Element == Vaccine {
    var reverseSortedByActiveDays: [Vaccine] {
        self.sorted { $0.activeDays > $1.activeDays }
    }
    
    var active: Int {
        self.filter { $0.activeDays >= 0 }.count
    }
    
    var expired: Int {
        self.filter { $0.activeDays < 0 }.count
    }
    
    var lastActive: Vaccine? {
        self.first(where: { $0.activeDays >= 0 })
    }
    
    var nextToExpire: Vaccine? {
        self.filter { $0.activeDays >= 0 }.min { $0.activeDays < $1.activeDays }
    }
}
