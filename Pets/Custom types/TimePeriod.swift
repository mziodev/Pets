//
//  TimePeriod.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import Foundation

enum TimePeriod: String, CaseIterable {
    case lastSixMonths
    case lastTwelveMonths
    
    var localizedDescription: String {
        switch self {
        case .lastSixMonths:
            String(localized: "Last 6 Months")
        case .lastTwelveMonths:
            String(localized: "Last 12 Months")
        }
    }
    
    var dateValue: Date {
        switch self {
        case .lastSixMonths:
            Date.now - (86400 * 180)
        case .lastTwelveMonths:
            Date.now - (86400 * 365)
        }
    }
}
