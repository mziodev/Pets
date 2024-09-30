//
//  petCard.swift
//  Pets
//
//  Created by MZiO on 27/5/24.
//

import SwiftUI

struct PetCard: View {
    @ObservedObject var pet: Pet
    
    @State private var showingPetDetail: Bool = false
    @State private var showingChipID: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PetImage(pet: pet)
                    .padding(.top)

                VStack(spacing: 10) {
                    PetCardName(name: pet.name)

                    PetCardBreed(breed: pet.breed)

                    PetCardAge(pet: pet)
                }
                .padding()
                
                LazyVGrid(
                    columns: [
                        GridItem(.fixed(165), spacing: 10),
                        GridItem(.fixed(165), spacing: 10)
                    ],
                    spacing: 10
                ) {
                    NavigationLink {
                        WeightList(pet: pet)
                    } label: {
                        WeightCard(pet: pet)
                    }
                    
                    NavigationLink {
                        DewormingTreatmentList(pet: pet)
                    } label: {
                        DewormingTreatmentsCard(pet: pet)
                    }
                    
                    NavigationLink {
                        VaccineList(pet: pet)
                    } label: {
                        VaccineCard(pet: pet)
                    }
                    .foregroundStyle(.primary)
                }
                .foregroundColor(.primary)
                .padding()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("\(pet.name)'s Card")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingPetDetail) {
                PetDetail(pet: pet)
            }
            .sheet(isPresented: $showingChipID) {
                MicrochipInfo(pet: pet)
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") { showingPetDetail = true }
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    //
                }
                
                ToolbarItem(placement: .status) {
                    if pet.chipID.type == .noChipID {
                        Text("No Microchip")
                            .font(.subheadline.smallCaps())
                    } else {
                        Button("Microchip") { showingChipID = true }
                            .font(.callout.smallCaps())
                            .bold()
                            .foregroundStyle(.petsFulvous)
                    }
                }
            }
        }
    }
}

#Preview("Pet with chip ID") {
    PetCard(pet: SampleData.shared.petWithChipID)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}

#Preview("Pet with expired vaccines") {
    PetCard(pet: SampleData.shared.petWithExpiredVaccines)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}

#Preview("Pet without weight") {
    PetCard(pet: SampleData.shared.petWithoutSpecies)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}
