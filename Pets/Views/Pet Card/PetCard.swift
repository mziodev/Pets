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
    @State private var showingVaccineList: Bool = false
    @State private var showingChipID: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                PetImage(pet: pet, imageSize: .medium)
                    .padding(.top)
                
                List {
                    PetCardName(name: pet.name)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    PetCardBreed(breed: pet.breed)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    
                    PetCardAge(pet: pet)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

                    PetCardWeight(pet: pet)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
            .padding(.top)
            .navigationTitle("\(pet.name)'s Card")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingPetDetail) {
                PetDetail(pet: pet)
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showingWeightDetail) {
                WeightList(pet: pet)
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showingDewormingTreatmentList) {
                DewormingTreatmentList(pet: pet)
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showingVaccineList) {
                VaccineList(pet: pet)
                    .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showingChipID) {
                PetChipInfo(pet: pet)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
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
                    
                    Button {
                        showingVaccineList = true
                    } label: {
                        Label("Vaccines", systemImage: "syringe")
                    }
                }
                
                ToolbarItem(placement: .status) {
                    if pet.chipID.number.isEmpty {
                        Text("No chip ID")
                            .font(.subheadline.smallCaps())
                    } else {
                        Button("Chip ID") { showingChipID = true }
                            .font(.callout.smallCaps())
                            .bold()
                            .foregroundStyle(.petsAccentBlue)
                    }
                }
            }
        }
    }
}


#Preview("Pet with chip ID") {
    PetCard(pet: SampleData.shared.petWithChipID)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Pet without chip ID") {
    PetCard(pet: SampleData.shared.petWithoutChipID)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Pet without weight") {
    PetCard(pet: SampleData.shared.petWithoutSpecies)
        .modelContainer(SampleData.shared.modelContainer)
}
