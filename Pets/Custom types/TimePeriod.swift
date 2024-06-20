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
    
    var id: Self { self }
}
