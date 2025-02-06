//
//  Vaccine+Activity.swift
//  Pets
//
//  Created by MZiO on 6/2/25.
//

import Foundation
import SwiftUI

extension Vaccine {
    
    var activeDays: Int {
        Int(ceil(ends.firstHour.timeIntervalSince(.now) / 86400))
    }
    
    var activeDaysColor: Color {
        let daysRange = 15...30
        
        if activeDays < 15 {
            return .red
        } else if daysRange.contains(activeDays) {
            return .yellow
        } else {
            return .green
        }
    }
    
    var isExpired: Bool { activeDays < 0 }
}
