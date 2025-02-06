//
//  Deworming+SampleData.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import Foundation

extension DewormingTreatment {
    
    static var sampleData = [
        DewormingTreatment(
            type: .liquid,
            units: .milliliters,
            name: "Fenbendazole",
            quantity: 5,
            startingDate: .now - (86400 * 31),
            endingDate: .now + (86400 * 2),
            notes: "Given to Bella"
        ),
            
        DewormingTreatment(
            type: .liquid,
            units: .milliliters,
            name: "Fenbendazole",
            quantity: 5,
            startingDate: .now - (86400 * 60),
            endingDate: .now - (86400 * 30),
            notes: "Given to Duke"
        ),
            
        DewormingTreatment(
            type: .injection,
            units: .millilitersPerKilogram,
            name: "Ivermectin",
            quantity: 10,
            startingDate: .now - (86400 * 25),
            endingDate: .now + (86400 * 5),
            notes: "Given to Daisy"
        ),
            
        DewormingTreatment(
            type: .injection,
            units: .millilitersPerKilogram,
            name: "Ivermectin",
            quantity: 10,
            startingDate: .now - (86400 * 55),
            endingDate: .now - (86400 * 25),
            notes: "Given to Charlie"
        ),
            
        DewormingTreatment(
            type: .pill,
            units: .units,
            name: "Praziquantel",
            quantity: 1.5,
            startingDate: .now - (86400 * 61),
            endingDate: .now + (86400 * 29),
            notes: "Given to Lucy"
        ),
            
        DewormingTreatment(
            type: .pill,
            units: .units,
            name: "Praziquantel",
            quantity: 1.25,
            startingDate: .now - (86400 * 150),
            endingDate: .now - (86400 * 60),
            notes: "Given to Buddy"
        ),
            
        DewormingTreatment(
            type: .liquid,
            units: .milliliters,
            name: "Pyrantel",
            quantity: 4,
            startingDate: .now - (86400 * 65),
            endingDate: .now - (86400 * 35),
            notes: "Given to Rocky"
        ),
            
        DewormingTreatment(
            type: .injection,
            units: .milliliters,
            name: "Pyrantel",
            quantity: 4.5,
            startingDate: .now - (86400 * 35),
            endingDate: .now + (86400 * 5),
            notes: "Given to Ginger"
        ),
            
        DewormingTreatment(
            type: .pill,
            units: .units,
            name: "Pyrantel",
            quantity: 1,
            startingDate: .now - (86400 * 25),
            endingDate: .now + (86400 * 15),
            notes: "Given to Max"
        ),
            
        DewormingTreatment(
            type: .collar,
            units: .units,
            name: "Seresto",
            quantity: 1,
            startingDate: .now - (86400 * 170),
            endingDate: .now + (86400 * 10),
            notes: "Given to Coco"
        ),
            
        DewormingTreatment(
            type: .collar,
            units: .units,
            name: "Seresto",
            quantity: 1,
            startingDate: .now - (86400 * 360),
            endingDate: .now - (86400 * 180),
            notes: "Given to Roofus"
        )
    ]
}
