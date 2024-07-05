//
//  PetListRow.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetListRow: View {
//    let name: String
//    let breed: String
//    let speciesName: String
    
    let pet: Pet
    
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(pet.name)
                    .font(.headline)
                
                Text(pet.breed.isEmpty ? String(localized: "Unknown breed") : pet.breed)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "\(pet.species.systemImage).fill")
                .font(.title2)
                .foregroundStyle(.petsAccentBlue)
        }
    }
}


#Preview("Dog") {
    List {
        PetListRow(pet: SampleData.shared.petWithChipID)
    }
}

#Preview("Cat") {
    List {
        PetListRow(pet: SampleData.shared.petWithExpiredVaccines)
    }
}

#Preview("No breed, no species") {
    List {
        PetListRow(pet: SampleData.shared.petWithoutSpecies)
    }
}
