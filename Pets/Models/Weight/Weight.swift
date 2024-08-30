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
    var date: Date = Date.now
    var value: Double = 0
    var pet: Pet?
    
    init(date: Date = .now, value: Double = 0) {
        self.date = date
        self.value = value
    }    
}
