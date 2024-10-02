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
    @State private var showingSupport = false
    @State private var showingWhatsNew: Bool = false
    @State private var showingPetsStore = false

    private var premiumCheckedPets: [Pet] {
        petsStoreManager.isPremiumUnlocked ? pets : pets.prefix(1).compactMap { $0 }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(premiumCheckedPets) { pet in
                        NavigationLink {
                            PetCard(pet: pet)
                        } label: {
                            PetListRow(pet: pet)
                        }
                    }
                    .onDelete(perform: deletePets)
                } footer: {
                    HStack {
                        Spacer()
                        
                        Text("\(premiumCheckedPets.count) pets")
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                }
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
            .sheet(isPresented: $showingSupport) {
                Support()
            }
            .sheet(isPresented: $showingWhatsNew) {
                WhatsNew()
            }
            .sheet(isPresented: $showingPetsStore) {
                PetsStoreView()
            }
            .toolbar {
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button {
                        showingWhatsNew = true
                    } label: {
                        Label("What's new", systemImage: "sparkles")
                    }
                    
                    Button {
                        showingPetsStore = true
                    } label: {
                        Label("Pets Premium", systemImage: "crown.fill")
                    }
                    
                    Button {
                        showAppStoreRating()
                    } label: {
                        Label("Rate this app", systemImage: "star.fill")
                    }
                    
                    Button {
                        showingSupport = true
                    } label: {
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
//                    
//                    ToolbarItem(placement: .status) {
//                        ZStack {
//                            Text("\(premiumCheckedPets.count) pets")
//                                .font(.caption)
//                        }
//                    }
                }
            }
        }
    }

    private func deletePets(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(pets[$0]) }
    }
    
    private func showAppStoreRating() {
        guard let url = URL(
            string: "itms-apps://itunes.apple.com/app/id6670243713?action=write-review"
        ) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(
                url,
                options: [:],
                completionHandler: nil
            )
        }
    }
}


#Preview {
    PetList()
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}
