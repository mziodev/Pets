//
//  Pet+Unwrapping.swift
//  Pets
//
//  Created by MZiO on 21/11/24.
//

import Foundation

extension Pet {
    var unwrappedWeights: [Weight] {
        weights ?? []
    }
    
    var unwrappedDewormingTreatments: [DewormingTreatment] {
        dewormingTreatments ?? []
    }
    
    var unwrappedVaccines: [Vaccine] {
        vaccines ?? []
    }
}
