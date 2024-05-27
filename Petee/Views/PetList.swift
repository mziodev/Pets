//
//  PetList.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

/*
 TODO:
 
    Add button for showing add menu: weight, vaccine, parasites, vet consultations...
 
    Add text with current weight
 */

import SwiftData
import SwiftUI

struct PetList: View {
    @Query(sort: \Pet.name) var pets: [Pet]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddPetSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(pets) { pet in
                    NavigationLink {
                        PetDetail(pet: pet)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(pet.name)
                                    .font(.headline)
                                
                                Text(pet.breed)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "\(pet.species.rawValue.lowercased()).fill")
                                .font(.title2)
                        }
                    }
                }
                .onDelete(perform: deletePets)
            }
            .navigationTitle("Pets")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingAddPetSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add pet")
                }
                
                ToolbarItem(placement: .status) {
                    Text("\(pets.count) pets")
                }
            }
            .sheet(isPresented: $showingAddPetSheet) {
                NavigationStack {
                    AddPet()
                }
            }
        }
    }
    
    private func deletePets(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(pets[index])
        }
    }
}

#Preview {
    PetList()
        .modelContainer(SampleData.shared.modelContainer)
}
