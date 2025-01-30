//
//  PetList.swift
//  Pets
//
//  Created by MZiO on 20/5/24.
//

import SwiftData
import SwiftUI

struct PetListView: View {
    
    @AppStorage("FirstStart") private var isFirstLaunch: Bool = true
    
    @Query(sort: \Pet.name) var pets: [Pet]
    
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    @State private var showingPetDetails = false
    @State private var showingWhatsNew = false
    @State private var showingPetsStore = false
    @State private var showingSupport = false

    private var premiumCheckedPets: [Pet] {
        if petsStoreManager.isPremiumUnlocked {
            pets
        } else  {
            pets.prefix(1).compactMap { $0 }
        }
    }
    
    private func showPetDetails() {
        showingPetDetails = true
    }
    
    private func showWhatsNewView() {
        showingWhatsNew = true
    }
    
    private func showPetsStoreView() {
        showingPetsStore = true
    }
    
    private func showSupportView() {
        showingSupport = true
    }
    
    private func showAppStoreRating() {
        let url = URLs.appStoreRatingURL
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func deletePets(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(pets[$0]) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if !pets.isEmpty {
                    Section {
                        ForEach(premiumCheckedPets) { pet in
                            NavigationLink {
                                PetCardView(pet: pet)
                            } label: {
                                PetListRowView(pet: pet)
                            }
                        }
                        .onDelete(perform: deletePets)
                    } header: {
                        HStack {
                            Spacer()
                            
                            Text("\(premiumCheckedPets.count) pets")
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationTitle("Pets")
            .overlay {
                if pets.isEmpty {
                    NoPetsYetView()
                }
            }
            .sheet(isPresented: $isFirstLaunch) {
                WelcomeView(isFirstStart: $isFirstLaunch)
            }
            .sheet(isPresented: $showingPetDetails) {
                if pets.count >= 1 && !petsStoreManager.isPremiumUnlocked {
                    PetsStoreView()
                } else {
                    PetDetailsView(pet: Pet(), isNew: true)
                }
            }
            .sheet(isPresented: $showingSupport) {
                SupportView()
            }
            .sheet(isPresented: $showingWhatsNew) {
                WhatsNewView()
            }
            .sheet(isPresented: $showingPetsStore) {
                PetsStoreView()
            }
            .toolbar {
                if !pets.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button(action: showWhatsNewView) {
                        Label("What's new", systemImage: "sparkles")
                    }
                    
                    Button(action: showPetsStoreView) {
                        Label("Pets Premium", systemImage: "crown.fill")
                    }
                    
                    Button(action: showAppStoreRating) {
                        Label("Rate this app", systemImage: "star.fill")
                    }
                    
                    Button(action: showSupportView) {
                        Label("Support", systemImage: "envelope.fill")
                    }
                }
                
                ToolbarItem(placement: .status) {
                    Button(action: showPetDetails) {
                        Label("Add pet", systemImage: "plus.circle.fill")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
        }
    }
}


#Preview {
    PetListView()
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}

struct PetListRowView: View {
    let pet: Pet
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(pet.name)
                    .font(.headline)
                
                Text(
                    pet.breed.isEmpty ? String(localized: "Unknown breed") : pet.breed
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "\(pet.species.symbol).fill")
                .font(.title2)
                .foregroundStyle(.accent)
                .accessibilityLabel(pet.species.symbolLocalizedDescription)
        }
    }
}

struct NoPetsYetView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No pets yet", systemImage: "pawprint.fill")
                .foregroundStyle(.accent)
        } description: {
            Text("Tap on the button '+' for add a new pet.")
        }
    }
}
