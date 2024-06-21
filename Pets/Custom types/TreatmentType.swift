//
//  DewormingType.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum TreatmentType: String, Codable, CaseIterable {
    case unknown
    case pill
    case liquid
    case pipette
    case spray
    case shampoo
    case collar
    case injection
    case additive
    case suppository
    case others
    
    var systemImage: String {
        switch self {
        case .unknown:
            return "ant"
        case .pill:
            return "pills"
        case .liquid:
            return "cross.vial"
        case .pipette:
            return "testtube.2"
        case .spray:
            return "humidifier.and.droplets"
        case .shampoo:
            return "bubbles.and.sparkles"
        case .collar:
            return "circle"
        case .injection:
            return "syringe"
        case .additive:
            return "waterbottle"
        case .suppository:
            return "pill"
        case .others:
            return "ivfluid.bag"
        }
    }
}
