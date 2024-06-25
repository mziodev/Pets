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
    @State private var showingWeightDetail: Bool = false
    @State private var showingDewormingTreatmentList: Bool = false
    @State private var showingChipIDBarcode: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                PetImage(pet: pet, imageSize: .large)
                
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
                    
//                    PetCardChipID(chipID: pet.chipID)
//                        .listRowSeparator(.hidden)
//                        .listRowBackground(Color.clear)

                    PetCardWeight(
                        pet: pet,
                        currentWeight: pet.currentWeight,
                        showingWeightDetail: $showingWeightDetail
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.insetGrouped)
                .scrollIndicators(.hidden)
            }
            .navigationTitle(pet.name)
            .sheet(isPresented: $showingPetDetail) {
                PetDetail(pet: pet)
            }
            .sheet(isPresented: $showingWeightDetail) {
                WeightList(pet: pet)
            }
            .sheet(isPresented: $showingDewormingTreatmentList) {
                DewormingTreatmentList(pet: pet)
            }
            .sheet(isPresented: $showingChipIDBarcode) {
                PetChipIDBarcode(chipID: pet.chipID)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit") { showingPetDetail = true }
                }
                
                ToolbarItemGroup(placement: .secondaryAction) {
                    Button {
                        showingWeightDetail = true
                    } label: {
                        Label("Weights", systemImage: "scalemass")
                    }
                    
                    Button {
                        showingDewormingTreatmentList = true
                    } label: {
                        Label("Dewormings", systemImage: "ant")
                    }
                }
                
                ToolbarItem(placement: .status) {
                    if pet.chipID.isEmpty {
                        Text("No chip ID")
                            .font(.subheadline.smallCaps())
                    } else {
                        Button("Chip ID") { showingChipIDBarcode = true }
                            .font(.headline.smallCaps())
                    }
                }
            }
        }
    }
}


#Preview("Pet with chip ID") {
    PetCard(pet: SampleData.shared.petWithChipID)
}

#Preview("Pet without chip ID") {
    PetCard(pet: SampleData.shared.petWithoutChipID)
}

#Preview("Pet without weight") {
    PetCard(pet: SampleData.shared.petWithoutSpecies)
}
