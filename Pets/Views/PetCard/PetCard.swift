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
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: 400, maxHeight: 700)
                .foregroundStyle(.thickMaterial)
                .clipShape(.rect(cornerRadius: 16))
                .overlay {
                    VStack {
                        PetImage(pet: pet, imageSize: .large)
                            .padding(.top)
                        
                        List {
                            PetCardBreed(breed: pet.breed)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)

                            
                            PetCardAge(
                                year: pet.age.first,
                                month: pet.age.last
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)

                            
                            PetCardWeight(pet: pet)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)

                            
                            PetCardChipID(chipID: pet.chipID)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                        .padding(.horizontal)
                        .scrollIndicators(.hidden)
                    }
                    .padding(.top)
                }
                .padding([.bottom, .horizontal])
        }
        .navigationTitle(pet.name)
        .sheet(isPresented: $showingPetDetail) {
            NavigationStack {
                PetDetail(pet: pet)
                    .interactiveDismissDisabled()
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") { showingPetDetail.toggle() }
            }
        }
    }
}


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
