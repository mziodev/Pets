 //
//  PetBreedList.swift
//  Pets
//
//  Created by MZiO on 10/6/24.
//


import SwiftUI

struct PetBreedListView: View {
    
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
            petBreedsSorted
        } else {
            petBreedsSorted.filter {
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
    
    private var selectedBreedText: String {
        pet.breed.isEmpty ? "Select a breed from below list" : "\(pet.breed) 🐾"
    }
    
    private func resetSearchable() {
        searchText = ""
        isSearchPresented = !searchText.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if pet.species != .unknown {
                    List {
                        Section("Selected Breed") {
                            Text(selectedBreedText)
                                .font(.headline)
                                .foregroundStyle(.accent)
                                .lineLimit(1)
                        }

                        Section("Breeds") {
                            ForEach(filteredPetBreedList) { breed in
                                if breed.variations.isEmpty {
                                    PetBreedListRow(pet: pet, breed: breed)
                                    .onTapGesture {
                                        withAnimation {
                                            if pet.breed == breed.name {
                                                pet.breed = ""
                                            } else {
                                                pet.breed = breed.name
                                            }
                                        }
                                        
                                        resetSearchable()
                                    }
                                } else {
                                    NavigationLink {
                                        PetBreedVariationListView(
                                            pet: pet,
                                            breed: breed
                                        )
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
                    .onAppear(perform: resetSearchable)
                } else {
                    NoBreedsYetView()
                }
            }
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
}


#Preview("Breed list is empty") {
    PetBreedListView(pet: SampleData.shared.petWithoutSpecies)
}

#Preview("Breed list is not empty") {
    PetBreedListView(pet: SampleData.shared.petWithChipID)
}

struct PetBreedListRow: View {
    
    let pet: Pet
    let breed: PetBreed
    
    var body: some View {
        HStack {
            Text(breed.name)
            
            Spacer()
            
            if pet.breed == breed.name {
                CheckMarkLabel()
            }
        }
        .contentShape(Rectangle()) // for getting tap gesture on the entire row
    }
}

struct NoBreedsYetView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No breeds yet", systemImage: "pawprint.fill")
                .foregroundStyle(.accent)
        } description: {
            Text("You have to select your pet species first.")
        }
    }
}
