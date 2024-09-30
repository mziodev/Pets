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
                        GridItem(.fixed(150), spacing: 10),
                        GridItem(.fixed(150), spacing: 10)
                    ]
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
            .sheet(isPresented: $showingWeightDetail) {
                WeightList(pet: pet)
            }
            .sheet(isPresented: $showingDewormingTreatmentList) {
                DewormingTreatmentList(pet: pet)
            }
            .sheet(isPresented: $showingVaccineList) {
                VaccineList(pet: pet)
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
}

#Preview("Pet with expired vaccines") {
    PetCard(pet: SampleData.shared.petWithExpiredVaccines)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Pet without weight") {
    PetCard(pet: SampleData.shared.petWithoutSpecies)
        .modelContainer(SampleData.shared.modelContainer)
}
