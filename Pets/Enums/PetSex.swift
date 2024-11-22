//
//  PetSex.swift
//  Petee
//
//  Created by MZiO on 23/5/24.
//

import Foundation

enum PetSex: String, CaseIterable, Codable {
    case unknown
    case male
    case female
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            String(localized: "Select a sex")
        case .male:
            String(localized: "Male")
        case .female:
            String(localized: "Female")
        }
    }
}
