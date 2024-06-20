//
//  SampleData.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            Pet.self,
            Weight.self,
            Deworming.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            
            insertSampleData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertSampleData() {
        for pet in Pet.sampleData {
            modelContext.insert(pet)
        }
        
        for weight in Weight.sampleData {
            modelContext.insert(weight)
        }
        
        for deworming in Deworming.sampleData {
            modelContext.insert(deworming)
        }
        
        Pet.sampleData[2].weights = [
            Weight.sampleData[7],
            Weight.sampleData[8],
        ]
        
        Pet.sampleData[1].weights = [
            Weight.sampleData[3],
            Weight.sampleData[4],
            Weight.sampleData[5],
            Weight.sampleData[6],
        ]
        
        Pet.sampleData[0].weights = [
            Weight.sampleData[0],
            Weight.sampleData[1],
            Weight.sampleData[2],
        ]
        
        do {
            try modelContext.save()
        } catch {
            print("Sample data modelContext failed to save.")
        }
    }
    
    var petWithChipID: Pet {
        Pet.sampleData[0]
    }
    
    var petWithoutChipID: Pet {
        Pet.sampleData[1]
    }
    
    var petWithoutSpecies: Pet {
        Pet.sampleData[3]
    }
}

