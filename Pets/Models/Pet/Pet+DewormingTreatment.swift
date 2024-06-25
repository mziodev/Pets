//
//  Pet+DewormingTreatment.swift
//  Pets
//
//  Created by MZiO on 25/6/24.
//

import Foundation

extension Pet {
    var reverseSortedDewormingTreatments: [DewormingTreatment] {
        dewormingTreatments.sorted { $0.activeDays > $1.activeDays }
    }
    
    var activeDewormingTreatments: Int {
        dewormingTreatments.filter { $0.activeDays > 0 }.count
    }
}
