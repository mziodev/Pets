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
    
    init(date: Date = .now, value: Double = 0) {
        self.date = date
        self.value = value
    }    
}
