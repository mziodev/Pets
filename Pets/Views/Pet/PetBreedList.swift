//
//  PetBreedList.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//


import SwiftUI

struct PetBreedList: View {
    @Bindable var pet: Pet
    
    @State private var searchText = ""
    @State private var isSearchPresented = false
    
    private var petBreedsSorted: [PetBreed] {
        PetBreedDataService.loadPetBreeds(
            from: "\(pet.species.rawValue)Breeds"
        )?.sorted { $0.name < $1.name } ?? []
    }
    private var filteredPetBreedList: [PetBreed] {
        if searchText.isEmpty {
            return petBreedsSorted
        } else {
            return petBreedsSorted.filter { $0.name.contains(searchText) }
        }
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if pet.species != .unknown {
                    List {
                        Section {
                            if !pet.breed.isEmpty {
                                HStack {
                                    Spacer()
                                    
                                    Text("I'm a \(pet.breed)")
                                        .font(.headline)
                                        .foregroundStyle(.petsAccentBlue)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .listRowBackground(Color.clear)

                        Section("Breeds") {
                            ForEach(filteredPetBreedList) { breed in
                                if breed.variations.isEmpty {
                                    PetBreedListRow(pet: pet, breed: breed)
                                        .onTapGesture {
                                            withAnimation {
                                                pet.breed = breed.name
                                            }
                                            
                                            resetSearchable()
                                        }
                                } else {
                                    NavigationLink {
                                        PetBreedVariationList(pet: pet, breed: breed)
                                    } label: {
                                        PetBreedListRow(pet: pet, breed: breed)
                                    }
                                }
                            }
                        }
                    }
                    .searchable(
                        text: $searchText,
                        isPresented: $isSearchPresented
                    )
                    .onAppear { resetSearchable() }
                } else {
                    PetBreedNoBreeds()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(pet.name)
            .navigationBarTitleDisplayMode(.inline)
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
