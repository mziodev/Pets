//
//  FormatUtilities.swift
//  Pets
//
//  Created by MZiO on 21/6/24.
//

import Foundation

struct FormatUtilities {
    static func changingCommasPerDots(in value: Double) -> Double {
        let stringValue = String(value)
        print(stringValue)
        
        return Double(stringValue.replacingOccurrences(of: ",", with: ".")) ?? 0
    }
    
//    static func changingCommasPerDots2(in value: Double) -> Double {
//        let formatter = NumberFormatter()
//        
//        formatter.locale = Locale(identifier: "en_US")
//        formatter.numberStyle = .decimal
//        formatter.decimalSeparator = "."
//            
//        return Double(formatter.string(from: NSNumber(value: value)) ?? "") ?? 0
//    }
}
