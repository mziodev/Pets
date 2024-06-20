//
//  Deworming+SampleData.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

extension Deworming {
    static var sampleData = [
        Deworming(
            type: .liquid,
            units: .milliliters,
            treatmentName: "Fenbendazole",
            quantity: 5,
            date: .now - (86400 * 31),
            expirationDate: .now + (86400 * 2),
            notes: "Given to Bella"
        ),
        Deworming(
            type: .injection,
            units: .milliliters,
            treatmentName: "Fenbendazole",
            quantity: 2,
            date: .now - (86400 * 60),
            expirationDate: .now - (86400 * 30),
            notes: "Given to Duke"
        ),
        Deworming(
            type: .pill,
            units: .milligrams,
            treatmentName: "Ivermectin",
            quantity: 1,
            date: .now - (86400 * 25),
            expirationDate: .now + (86400 * 5),
            notes: "Given to Daisy"
        ),
        Deworming(
            type: .injection,
            units: .milliliters,
            treatmentName: "Ivermectin",
            quantity: 1,
            date: .now - (86400 * 55),
            expirationDate: .now - (86400 * 25),
            notes: "Given to Charlie"
        ),
        Deworming(
            type: .pill,
            units: .milligrams,
            treatmentName: "Praziquantel",
            quantity: 3,
            date: .now - (86400 * 61),
            expirationDate: .now + (86400 * 29),
            notes: "Given to Lucy"
        ),
        Deworming(
            type: .liquid,
            units: .milliliters,
            treatmentName: "Praziquantel",
            quantity: 5,
            date: .now - (86400 * 150),
            expirationDate: .now - (86400 * 60),
            notes: "Given to Buddy"
        ),
        Deworming(
            type: .liquid,
            units: .milliliters,
            treatmentName: "Pyrantel",
            quantity: 4,
            date: .now - (86400 * 65),
            expirationDate: .now - (86400 * 35),
            notes: "Given to Rocky"
        ),
        Deworming(
            type: .injection,
            units: .milliliters,
            treatmentName: "Pyrantel",
            quantity: 3,
            date: .now - (86400 * 35),
            expirationDate: .now + (86400 * 5),
            notes: "Given to Ginger"
        ),
        Deworming(
            type: .pill,
            units: .milligrams,
            treatmentName: "Pyrantel",
            quantity: 1,
            date: .now - (86400 * 25),
            expirationDate: .now + (86400 * 15),
            notes: "Given to Max"
        ),
        Deworming(
            type: .collar,
            units: .milligramsPerKilogram,
            treatmentName: "Seresto",
            quantity: 1,
            date: .now - (86400 * 170),
            expirationDate: .now + (86400 * 10),
            notes: "Given to Coco"
        ),
        Deworming(
            type: .collar,
            units: .milligramsPerKilogram,
            treatmentName: "Seresto",
            quantity: 1,
            date: .now - (86400 * 360),
            expirationDate: .now - (86400 * 180),
            notes: "Given to Roofus"
        )
    ]
}
