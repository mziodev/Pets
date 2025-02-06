//
//  Pet+Age.swift
//  Pets
//
//  Created by MZiO on 6/2/25.
//

import Foundation

extension Pet {
    
    var age: String {
        let age = years(from: birthday)
        var ageString = ""
        
        if let yearString = age["year"] {
            ageString += yearString + " "
        }
        
        if let monthString = age["month"] {
            ageString += monthString + " "
        }
        
        if let dayString = age["day"] {
            ageString += dayString
        }
        
        return ageString
    }
    
    var inFamilyYears: String {
        let inFamilyYears = years(from: onFamilySince)
        var inFamilyYearsString = ""
        
        if let yearString = inFamilyYears["year"] {
            inFamilyYearsString += yearString + " "
        }
        
        if let monthString = inFamilyYears["month"] {
            inFamilyYearsString += monthString + " "
        }
        
        if let dayString = inFamilyYears["day"] {
            inFamilyYearsString += dayString
        }
        
        return inFamilyYearsString
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
