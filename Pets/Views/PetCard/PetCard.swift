//
//  petCard.swift
//  Pets
//
//  Created by MZiO on 27/5/24.
//

import SwiftUI

struct PetCard: View {
    let pet: Pet
    
    @State private var showingPetDetail: Bool = false
    
    private var currentWeight: Double {
        pet.reverseSortedWeights.first?.value ?? 0
    }
    
    
    // MARK: - body
    var body: some View {
        VStack {
            PetImage(pet: pet, imageSize: .large)
        
            List {
                PetCardBreed(breed: pet.breed)
                    .listRowSeparator(.hidden)
                
                PetCardAge(
                    year: pet.age.first,
                    month: pet.age.last
                )
                .listRowSeparator(.hidden)
                
                PetCardWeight(pet: pet)
                .listRowSeparator(.hidden)
                
                PetCardChipID(chipID: pet.chipID)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .padding(.top)
        }
        .navigationTitle(pet.name)
        .padding()
        
        
        // MARK: - PetDetail sheet
        .sheet(isPresented: $showingPetDetail) {
            NavigationStack {
                PetDetail(pet: pet)
                    .interactiveDismissDisabled()
            }
        }
        
        
        // MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") { showingPetDetail.toggle() }
            }
        }
    }
}


// MARK: - previews
#Preview("Pet with chip ID") {
    NavigationStack {
        PetCard(pet: SampleData.shared.petWithChipID)
    }
}

#Preview("Pet without chip ID") {
    NavigationStack {
        PetCard(pet: SampleData.shared.petWithoutChipID)
    }
}

#Preview("Pet without weight") {
    NavigationStack {
        PetCard(pet: SampleData.shared.petWithoutSpecies)
    }
}
