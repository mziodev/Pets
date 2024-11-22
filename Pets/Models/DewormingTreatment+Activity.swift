//
//  DewormingTreatment+Activity.swift
//  Pets
//
//  Created by MZiO on 21/11/24.
//

import SwiftUI

extension DewormingTreatment {
    var activeDays: Int {
        Int(ceil(endingDate.firstHour.timeIntervalSince(.now) / 86400))
    }
    
    var activeDaysColor: Color {
        let daysRange = 7...15
        
        if activeDays < 7 {
            return .red
        } else if daysRange.contains(activeDays) {
            return .yellow
        } else {
            return .green
        }
    }
    
    var isActive: Bool {
        self.activeDays >= 0 // 0 represents today, the last active day because tomorrow it'll be expired.
    }
}
