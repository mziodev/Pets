//
//  PetBreedVariationList.swift
//  Pets
//
//  Created by MZiO on 11/6/24.
//

import SwiftUI

struct PetBreedVariationListView: View {
    
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
                            CheckMarkLabel()
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            if pet.breed == "\(breed.name), \(variation)" {
                                pet.breed = ""
                            } else {
                                pet.breed = "\(breed.name), \(variation)"
                                dismiss()
                            }
                        }
                    }
                    .contentShape(Rectangle()) // for the getting tap gesture on the entire row
                }
            }
            .navigationTitle("\(breed.name) variations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PetBreedVariationListView(
        pet: SampleData.shared.petWithoutChipID,
        breed: PetBreed.sampledata[1]
    )
}
