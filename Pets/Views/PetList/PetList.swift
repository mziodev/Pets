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
                        PetListRow(
                            name: pet.name,
                            breed: pet.breed,
                            speciesName: pet.species.rawValue
                        )
                    }
                }
                .onDelete(perform: deletePets)
            }
            .navigationTitle("Pets")
            .overlay {
                if pets.isEmpty { PetListNoPetsYet() }
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showingAddPetSheet.toggle()
                    } label: {
                        Label("Add pet", systemImage: "plus")
                    }
                }
                
                if !pets.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    
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
