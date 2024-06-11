//
//  PetBreedList.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//

import SwiftUI

struct PetBreedList: View {
    @Bindable var pet: Pet
    
    private var petBreedList: [PetBreed] {
        PetBreedDataService.loadPetBreeds(
            from: "\(pet.species.rawValue)Breed"
        ) ?? []
    }
    private var filteredPetBreedList: [PetBreed] {
        if searchText.isEmpty {
            return petBreedList
        } else {
            return petBreedList.filter { $0.name.contains(searchText) }
        }
    }
    
    @State private var searchText: String = ""
    
    var body: some View {
        if pet.species != .unknown {
            VStack {
                if !pet.breed.isEmpty {
                    Text("I'm a \(pet.breed)")
                        .font(.callout)
                        .bold()
                        .foregroundStyle(.tint)
                        .padding()
                        .lineLimit(1)
                }
                
                List {
                    ForEach(filteredPetBreedList) { breed in
                        if breed.variations.isEmpty {
                            PetBreedListRow(pet: pet, breed: breed)
                                .onTapGesture { pet.breed = breed.name }
                        } else {
                            NavigationLink {
                                PetBreedVariationList(pet: pet, breed: breed)
                            } label: {
                                PetBreedListRow(pet: pet, breed: breed)
                            }
                            
                        }
                    }
                }
                .searchable(text: $searchText)
                .listStyle(.plain)
            }
            .navigationTitle(pet.name)
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("\(petBreedList.count) breeds")
                        .font(.caption)
                }
            }
        } else {
            Text("You have to select your pet species first.")
                .padding()
        }
    }
}


// MARK: - previews
#Preview("Breed list is empty") {
    NavigationStack {
        PetBreedList(pet: SampleData.shared.petWithoutSpecies)
    }
}

#Preview("Breed list is not empty") {
    NavigationStack {
        PetBreedList(pet: SampleData.shared.petWithChipID)
    }
}
