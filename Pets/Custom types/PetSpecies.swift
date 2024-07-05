//
//  PetSpecies.swift
//  Petee
//
//  Created by MZiO on 23/5/24.
//

import Foundation

enum PetSpecies: String, CaseIterable, Codable {
    case unknown = "pawprint"
    case cannine = "dog"
    case feline = "cat"
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            String(localized: "Unknown")
        case .cannine:
            String(localized: "Dog")
        case .feline:
            String(localized: "Cat")
        }
    }
}
