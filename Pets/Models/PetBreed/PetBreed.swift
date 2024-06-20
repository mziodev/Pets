//
//  PetBreed.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import Foundation

struct PetBreed: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var variations: [String]
}
