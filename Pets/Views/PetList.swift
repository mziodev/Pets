//
//  PetList.swift
//  Pets
//
//  Created by MZiO on 20/5/24.
//

import SwiftData
import SwiftUI

struct PetList: View {
    @Query(sort: \Pet.name) var pets: [Pet]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddPetSheet = false
    
    
    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                ForEach(pets) { pet in
                    NavigationLink {
                        PetCard(pet: pet)
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
                            
                            Image(systemName: "\(pet.species.rawValue).fill")
                                .font(.title2)
                        }
                    }
                }
                .onDelete(perform: deletePets)
            }
            .navigationTitle("Pets")
            .overlay {
                if pets.isEmpty { NoPetsYet() }
            }
            
            
            // MARK: - add pet sheet
            .sheet(isPresented: $showingAddPetSheet) {
                NavigationStack {
                    PetDetail(pet: Pet(), isNew: true)
                        .interactiveDismissDisabled()
                }
            }
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem() {
                    Button{
                        showingAddPetSheet.toggle()
                    } label: {
                        Label("Add pet", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                
                if !pets.isEmpty {
                    ToolbarItem(placement: .status) {
                        Text("\(pets.count) pets")
                            .font(.caption)
                    }
                }
            }
                
        }
    }
    
    
    // MARK: - functions
    private func deletePets(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(pets[$0]) }
    }
}


// MARK: - previews
#Preview("Light mode") {
    PetList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Dark mode") {
    PetList()
        .modelContainer(SampleData.shared.modelContainer)
        .preferredColorScheme(.dark)
}
