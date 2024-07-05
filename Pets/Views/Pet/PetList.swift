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
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(pets) { pet in
                    NavigationLink {
                        PetCard(pet: pet)
                    } label: {
                        PetListRow(pet: pet)
                    }
                }
                .onDelete(perform: deletePets)
            }
            .navigationTitle("Pets")
            .overlay {
                if pets.isEmpty { PetListNoPets() }
            }
            .sheet(isPresented: $showingAddPetSheet) {
                PetDetail(pet: Pet(), isNew: true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showingAddPetSheet = true
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
    

    private func deletePets(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(pets[$0]) }
    }
}


#Preview {
    PetList()
        .modelContainer(SampleData.shared.modelContainer)
}
