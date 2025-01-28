//
//  PetsApp.swift
//  Pets
//
//  Created by MZiO on 20/5/24.
//

import SwiftData
import SwiftUI

@main
struct PetsApp: App {
    @StateObject private var petsStoreManager = PetsStoreManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pet.self,
            Weight.self,
            DewormingTreatment.self,
            Vaccine.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            PetListView()
                .modelContainer(sharedModelContainer)
                .environmentObject(petsStoreManager)
                .task {
                    await petsStoreManager.updatePurchasedProducts()
                }
        }
    }
}
