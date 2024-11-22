//
//  NotificationPeriod.swift
//  Pets
//
//  Created by MZiO on 9/9/24.
//

import Foundation

enum NotificationPeriod: Codable, CaseIterable {
    case none
    case sameDay
    case dayBefore
    case twoDaysBefore
    case weekBefore
    case twoWeeksBefore
    case monthBefore
    
    var value: Int {
        switch self {
        case .none:
            -1
        case .sameDay:
            0
        case .dayBefore:
            1
        case .twoDaysBefore:
            2
        case .weekBefore:
            7
        case .twoWeeksBefore:
            15
        case .monthBefore:
            30
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .none:
            String(localized: "None")
        case .sameDay:
            String(localized: "The same day")
        case .dayBefore:
            String(localized: "A day before")
        case .twoDaysBefore:
            String(localized: "Two days before")
        case .weekBefore:
            String(localized: "A week before")
        case .twoWeeksBefore:
            String(localized: "Two weeks before")
        case .monthBefore:
            String(localized: "A month before")
        }
    }
}
