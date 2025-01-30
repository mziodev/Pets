//
//  PetCardSummarySource.swift
//  Pets
//
//  Created by MZiO on 30/1/25.
//

import Foundation

enum PetCardSummarySource {
    case weights
    case dewormings
    case vaccines
    
    var localizedName: String {
        switch self {
        case .weights:
            String(localized: "Weights")
        case .dewormings:
            String(localized: "Dewormings")
        case .vaccines:
            String(localized: "Vaccines")
        }
    }
}
