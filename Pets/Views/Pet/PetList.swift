//
//  PetList.swift
//  Pets
//
//  Created by MZiO on 20/5/24.
//

import SwiftData
import SwiftUI

struct PetList: View {
    @AppStorage("FirstStart") private var isFirstLaunch: Bool = true
    
    @Query(sort: \Pet.name) var pets: [Pet]
    
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    @State private var showingAddPet = false
    @State private var showingPetsStore = false

    private var premiumCheckedPets: [Pet] {
        petsStoreManager.isPremiumUnlocked ? pets : pets.prefix(1).compactMap { $0 }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(premiumCheckedPets) { pet in
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
            .sheet(isPresented: $isFirstLaunch) {
                Welcome(isFirstStart: $isFirstLaunch)
            }
            .sheet(isPresented: $showingAddPet) {
                if pets.count >= 1 && !petsStoreManager.isPremiumUnlocked {
                    PetsStoreView()
                } else {
                    PetDetail(pet: Pet(), isNew: true)
                }
            }
            .sheet(isPresented: $showingPetsStore) { PetsStoreView() }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingPetsStore = true
                    } label: {
                        PremiumButtonLabel(
                            isPremium: petsStoreManager.isPremiumUnlocked
                        )
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showingAddPet = true
                    } label: {
                        Label("Add pet", systemImage: "plus")
                    }
                }
                
                if !pets.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        ZStack {
                            Text("\(premiumCheckedPets.count) pets")
                                .font(.caption)
                        }
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
        .environmentObject(PetsStoreManager())
}
