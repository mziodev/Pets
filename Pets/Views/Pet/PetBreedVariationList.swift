//
//  PetBreedVariationList.swift
//  Pets
//
//  Created by MZiO on 11/6/24.
//

import SwiftUI

struct PetBreedVariationList: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    let breed: PetBreed
    
    var body: some View {
        NavigationStack {
            VStack {
                List(breed.variations, id: \.self) { variation in
                    HStack {
                        Text(variation)
                        
                        Spacer()
                        
                        if pet.breed == "\(breed.name), \(variation)" {
                            Image(systemName: "checkmark.circle")
                                .font(.title3)
                                .foregroundStyle(.petsAccentBlue)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            pet.breed = "\(breed.name), \(variation)"
                        }
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("\(breed.name) variations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PetBreedVariationList(
        pet: SampleData.shared.petWithoutChipID,
        breed: PetBreed.sampledata[1]
    )
}
