//
//  Pet.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import Foundation
import SwiftData

@Model
class Pet: Equatable, ObservableObject {
    var species: PetSpecies = PetSpecies.unknown
    var sex: PetSex = PetSex.unknown
    var name: String = ""
    var breed: String = ""
    var chipID: ChipID = ChipID()
    var isAdopted: Bool = false
    var birthday: Date = Date.now
    var onFamilySince: Date = Date.now
    
    @Attribute(.externalStorage)
    var image: Data?    
    var imageScale: CGFloat = 1
    var imageOffsetX: CGFloat = 0
    var imageOffsetY: CGFloat = 0
    
    @Relationship(deleteRule: .cascade)
    var weights: [Weight]? = [Weight]()
    
    @Relationship(deleteRule: .cascade)
    var dewormingTreatments: [DewormingTreatment]? = [DewormingTreatment]()
    
    @Relationship(deleteRule: .cascade)
    var vaccines: [Vaccine]? = [Vaccine]()
    
    init(
        species: PetSpecies = .unknown,
        sex: PetSex = .unknown,
        name: String = "",
        breed: String = "",
        chipID: ChipID = ChipID(),
        adopted: Bool = false,
        birthday: Date = .now,
        onFamilySince: Date = .now,
        image: Data? = nil
    ) {
        self.species = species
        self.sex = sex
        self.name = name
        self.breed = breed
        self.chipID = chipID
        self.birthday = birthday
        self.onFamilySince = onFamilySince
        self.isAdopted = adopted
        self.image = image
    }
}
