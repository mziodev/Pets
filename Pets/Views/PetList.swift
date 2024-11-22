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
    
    @Query(sort: \Pet.name) private var pets: [Pet]
    
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var petsStoreManager: PetsStoreManager
    
    @State private var selectedPet : Pet?
    
    @State private var showingAddPet = false
    @State private var showingSupport = false
    @State private var showingWhatsNew = false
    @State private var showingPetsStore = false

    private var premiumCheckedPets: [Pet] {
        petsStoreManager.isPremiumUnlocked ? pets : pets.prefix(1).compactMap { $0 }
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedPet) {
                if !pets.isEmpty {
                    Section {
                        ForEach(premiumCheckedPets) { pet in
                            NavigationLink(value: pet) {
                                PetListRow(pet: pet)
                            }
                        }
                        .onDelete(perform: deletePets)
                    } header: {
                        PetListHeader(petNumber: premiumCheckedPets.count)
                    }
                }
            }
            .navigationTitle("Pets")
            .overlay {
                if pets.isEmpty { PetListNoPets() }
            }
            .sheet(isPresented: $isFirstLaunch) {
                Welcome(isFirstStart: $isFirstLaunch)
            }
            .sheet(isPresented: $showingWhatsNew) {
                WhatsNew()
            }
            .sheet(isPresented: $showingPetsStore) {
                PetsStoreView()
            }
            .sheet(isPresented: $showingSupport) {
                Support()
            }
            .sheet(isPresented: $showingAddPet) {
                if !pets.isEmpty && !petsStoreManager.isPremiumUnlocked {
                    PetsStoreView()
                } else {
                    PetDetail(pet: Pet(), isNew: true)
                }
            }
            .toolbar {
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showWhatsNew) {
                        Label("What's new", systemImage: "sparkles")
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showPetsStore) {
                        Label("Pets Premium", systemImage: "crown.fill")
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showAppStoreRating) {
                        Label("Rate this app", systemImage: "star.fill")
                    }
                }
                
                ToolbarItem(placement: .secondaryAction) {
                    Button(action: showSupport) {
                        Label("Support", systemImage: "envelope.fill")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button{
                        showingAddPet = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            
                            Text("Add pet")
                        }
                    }
                }
                
                if !pets.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
        } detail: {
            if let selectedPet = selectedPet {
                PetCard(pet: selectedPet)
            } else {
                Text("Select a pet to show its card.")
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func deletePets(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(pets[$0]) }
    }
    
    private func showWhatsNew() {
        showingWhatsNew = true
    }
    
    private func showPetsStore() {
        showingPetsStore = true
    }
    
    private func showAppStoreRating() {
        let url = URLs.writeReviewURL
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(
                url,
                options: [:],
                completionHandler: nil
            )
        }
    }
    
    private func showSupport() {
        showingSupport = true
    }
}


#Preview {
    PetList()
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}
