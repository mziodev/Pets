//
//  TimePeriod.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
    case lastSixMonthsPeriod = "Last 6 Months"
    case lastTwelveMonthsPeriod = "Last 12 months"
    
    var dateValue: Date {
        switch self {
        case .lastSixMonthsPeriod:
            return Date.now - (86400 * 180)
        case .lastTwelveMonthsPeriod:
            return Date.now - (86400 * 365)
        }
    }
    
    var id: Self { self }
}
