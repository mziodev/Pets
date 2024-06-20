//
//  DewormingType.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

enum DewormingType: Codable, CaseIterable {
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
}
