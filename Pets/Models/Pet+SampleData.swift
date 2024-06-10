//
//  Pet+SampleData.swift
//  Pets
//
//  Created by MZiO on 8/6/24.
//

import Foundation

extension Pet {
    static let sampleData = [
        Pet(
            species: .canine,
            sex: .male,
            name: "Rocky",
            breed: "Jack Russell",
            chipIDType: .fifteenDigits,
            chipID: "123456789098765",
            adopted: true,
            birthday: .now - (86400 * 500),
            onFamilySince: .now - (86400 * 5)
        ),
        
        Pet(
            species: .canine,
            sex: .male,
            name: "Tom",
            breed: "Puddle",
            adopted: false,
            birthday: .now - (86400 * 370),
            onFamilySince: .now - (86400 * 50)
        ),
        
        Pet(
            species: .feline,
            sex: .female,
            name: "Lia",
            breed: "Sphinx",
            adopted: false,
            birthday: .now - (86400 * 30),
            onFamilySince: .now - (86400 * 5)
        ),
    ]
}
