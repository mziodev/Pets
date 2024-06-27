//
//  PetBreedList.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//


import SwiftUI

struct PetBreedList: View {
    @Bindable var pet: Pet
    
    private var petBreedsSorted: [PetBreed] {
        PetBreedDataService.loadPetBreeds(
            from: "\(pet.species.rawValue)Breed"
        )?.sorted { $0.name < $1.name } ?? []
    }
    private var filteredPetBreedList: [PetBreed] {
        if searchText.isEmpty {
            return petBreedsSorted
        } else {
            return petBreedsSorted.filter { $0.name.contains(searchText) }
        }
    }
    
    @State private var searchText = ""
    @State private var isSearchPresented = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if pet.species != .unknown {
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
                                    .listRowBackground(Color.clear)
                                    .onTapGesture {
                                        pet.breed = breed.name
                                        
                                        resetSearchable()
                                    }
                            } else {
                                NavigationLink {
                                    PetBreedVariationList(
                                        pet: pet,
                                        breed: breed
                                    )
                                } label: {
                                    PetBreedListRow(pet: pet, breed: breed)
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .searchable(
                        text: $searchText,
                        isPresented: $isSearchPresented
                    )
                    .onAppear { resetSearchable() }
                } else {
                    Text("You have to select your pet species first.")
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(PetColors.backgroundGradient)
            .navigationTitle(pet.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.petsBGDarkBlue, for: .bottomBar)
            .toolbarBackground(.visible, for: .bottomBar)
            .toolbar {
                if pet.species != .unknown {
                    ToolbarItem(placement: .status) {
                        Text("\(petBreedsSorted.count) breeds")
                            .font(.caption)
                    }
                }
            }
        }
        
    }
    
    
    private func resetSearchable() {
        searchText = ""
        isSearchPresented = !searchText.isEmpty
    }
}


#Preview("Breed list is empty") {
    PetBreedList(pet: SampleData.shared.petWithoutSpecies)
}

#Preview("Breed list is not empty") {
    PetBreedList(pet: SampleData.shared.petWithChipID)
}
