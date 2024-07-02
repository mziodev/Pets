//
//  Pet+Vaccine.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import Foundation

extension Pet {
    var reverseSortedVaccines: [Vaccine] {
        vaccines.sorted { $0.activeDays > $1.activeDays }
    }
    
    var activeVaccines: Int {
        vaccines.filter { $0.activeDays > 0 }.count
    }
    
    var expiredVaccines: Int {
        vaccines.filter { $0.activeDays <= 0 }.count
    }
}
