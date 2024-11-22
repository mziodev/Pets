//
//  Pet+Dates.swift
//  Pets
//
//  Created by MZiO on 21/11/24.
//

import Foundation

extension Pet {
    var age: [String: String] {
        years(from: birthday)
    }
    
    var onFamilyYears: [String: String] {
        years(from: onFamilySince)
    }
    
    /// Calculates the years, months and days until a date.
    ///
    /// - returns: An array with up to three strings: the first one representing the years, the second one representing the months,
    /// and the third one (only if the last two are zero) representing the days,
    ///
    /// - Note: This property assumes `date` is a valid date in the past.
    private func years(from date: Date) -> [String: String] {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date, to: .now)
        
        let year = dateComponents.year ?? 0
        let month = dateComponents.month ?? 0
        let day = dateComponents.day ?? 0
        
        var age: [String: String] = [:]
        
        if year > 0 { age["year"] = String(localized: "\(year) years") }
        
        if month > 0 {
            age["month"] = year > 0 ? String(localized: "& \(month) months") : String(localized: "\(month) months")
        }
        
        if year == 0 && month == 0 { age["day"] = String(localized: "\(day) days") }

        return age
    }
}
