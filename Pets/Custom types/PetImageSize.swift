//
//  PetImageSize.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

enum PetImageSize: Double {
    case small
    case medium
    
    var value: CGFloat {
        switch self {
        case .small: return 150
        case .medium: return 220
        }
    }
}
