//
//  Weight.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

import Foundation
import SwiftData

@Model
class Weight {
    var date: Date
    var value: Double
    var pet: Pet?
    
    
    // MARK: - init
    init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }    
}
