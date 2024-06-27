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
                    Section {
                        HStack {
                            Text(variation)
                            
                            Spacer()
                            
                            if pet.breed == "\(breed.name), \(variation)" {
                                Image(systemName: "checkmark.circle")
                                    .font(.title3)
                                    .foregroundStyle(.tint)
                            }
                            
                        }
                        .onTapGesture {
                            pet.breed = "\(breed.name), \(variation)"
                            
                            dismiss()
                    }
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
            .navigationTitle(breed.name)
            .background(PetColors.backgroundGradient)
        }
    }
}

#Preview {
    PetBreedVariationList(
        pet: SampleData.shared.petWithoutChipID,
        breed: PetBreed.sampledata[1]
    )
}
