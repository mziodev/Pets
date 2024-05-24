//
//  TimePeriod.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
    case lastSixMonths = "Last 6 Months"
    case lastTwelveMonths = "Last 12 months"
    
    var id: Self { self }
}
