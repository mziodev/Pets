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
            species: .cannine,
            sex: .male,
            name: "Rocky",
            breed: "Jack Russell Terrier",
            chipID: ChipID(
                type: .fifteenDigits,
                number: "123456789098765",
                implantedDate: .now - (86400 * 10),
                location: "Neck, left side."
            ),
            adopted: true,
            birthday: .now - (86400 * 500),
            onFamilySince: .now - (86400 * 5)
        ),
        
        Pet(
            species: .cannine,
            sex: .male,
            name: "Tom",
            breed: "Pooddle, Toy",
            adopted: false,
            birthday: .now - (86400 * 370),
            onFamilySince: .now - (86400 * 50)
        ),
        
        Pet(
            species: .feline,
            sex: .female,
            name: "Lia",
            breed: "Sphynx",
            adopted: false,
            birthday: .now - (86400 * 30),
            onFamilySince: .now - (86400 * 5)
        ),
        
        Pet(
            species: .unknown,
            sex: .male,
            name: "Ruffo",
            breed: "",
            adopted: false,
            birthday: .now - (86400 * 770),
            onFamilySince: .now - (86400 * 320)
        ),
    ]
}
