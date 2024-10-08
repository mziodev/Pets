//
//  PetSpecies.swift
//  Petee
//
//  Created by MZiO on 23/5/24.
//

import Foundation

enum PetSpecies: String, CaseIterable, Codable {
    case unknown
    case cannine
    case feline
    
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
    
    var symbol: String {
        switch self {
        case .unknown:
            "pawprint"
        case .cannine:
            "dog"
        case .feline:
            "cat"
        }
    }
    
    var symbolLocalizedDescription: String {
        switch self {
        case .unknown:
            String(localized: "Paw symbol")
        case .cannine:
            String(localized: "Dog symbol")
        case .feline:
            String(localized: "Cat symbol")
        }
    }
}
