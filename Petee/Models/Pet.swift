//
//  Pet.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import Foundation
import SwiftData

@Model
class Pet {
    let type: PetType
    var name: String
    var birthday: Date
    var breed: String
    var image: String?
    var adopted: Bool
    var onFamilySince: Date
    
    init(
        type: PetType,
        name: String,
        birthday: Date,
        breed: String,
        image: String? = nil,
        adopted: Bool,
        onFamilySince: Date
    ) {
        self.type = type
        self.name = name
        self.birthday = birthday
        self.breed = breed
        self.image = image
        self.adopted = adopted
        self.onFamilySince = onFamilySince
    }
}

extension Pet {
    static let sampleData = [
        Pet(
            type: .dog,
            name: "Rocky",
            birthday: .now - (86400 * 300),
            breed: "Jack Russell",
            adopted: true,
            onFamilySince: .now - (86400 * 5)
        ),
        Pet(
            type: .dog,
            name: "Tom",
            birthday: .now - (86400 * 150),
            breed: "Puddle",
            adopted: false,
            onFamilySince: .now - (86400 * 50)
        ),
        Pet(
            type: .cat,
            name: "Lia",
            birthday: .now - (86400 * 200),
            breed: "Sphinx",
            adopted: false,
            onFamilySince: .now - (86400 * 100)
        ),
    ]
}
