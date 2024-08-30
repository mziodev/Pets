//
//  PetBreedListRow.swift
//  Pets
//
//  Created by MZiO on 11/6/24.
//

import SwiftUI

struct PetBreedListRow: View {
    @Bindable var pet: Pet
    
    let breed: PetBreed
    
    var body: some View {
        HStack {
            Text(breed.name)
            
            Spacer()
            
            if pet.breed == breed.name {
                Image(systemName: "checkmark.circle")
                    .font(.title3)
                    .foregroundStyle(.petsAccentBlue)
            }
        }
        .contentShape(Rectangle()) // for the getting tap gesture on the entire row
    }
}

#Preview {
    PetBreedListRow(pet: SampleData.shared.petWithChipID, breed: PetBreed.sampledata[0])
        .padding()
}
