//
//  TimePeriod.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
    case lastSixMonthsPeriod
    case lastTwelveMonthsPeriod
    
    var description: String {
        switch self {
        case .lastSixMonthsPeriod:
            String(localized: "Last 6 Months")
        case .lastTwelveMonthsPeriod:
            String(localized: "Last 12 Months")
        }
    }
    
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
