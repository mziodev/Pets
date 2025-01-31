//
//  petCard.swift
//  Pets
//
//  Created by MZiO on 27/5/24.
//

import SwiftUI

struct PetCardView: View {
    
    @ObservedObject var pet: Pet
    
    @State private var showingPetDetail: Bool = false
    @State private var showingChipID: Bool = false
    
    private let gridColumns = [
        GridItem(.fixed(165), spacing: 10),
        GridItem(.fixed(165), spacing: 10)
    ]
    
    private func showPetDetailsView() {
        showingPetDetail = true
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PetImageView(pet: pet)
                    .padding(.top)

                VStack(spacing: 10) {
                    PetFeature(
                        feature: String(localized: "Name"),
                        value: pet.name
                    )
                    
                    PetFeature(
                        feature: String(localized: "Breed"),
                        value: pet.breed
                    )
                    
                    PetFeature(
                        feature: String(localized: "Age"),
                        value: pet.age
                    )
                    
                    PetFeature(
                        feature: String(localized: "In the Family for"),
                        value: pet.inFamilyYears
                    )
                }
                .padding()
                
                LazyVGrid(columns: gridColumns, spacing: 10) {
                    NavigationLink {
                        WeightListView(pet: pet)
                    } label: {
                        PetCardSummaryView(pet: pet, summarySource: .weights)
                    }
                    
                    NavigationLink {
                        DewormingTreatmentList(pet: pet)
                    } label: {
                        PetCardSummaryView(pet: pet, summarySource: .dewormings)
                    }
                    
                    NavigationLink {
                        VaccineListView(pet: pet)
                    } label: {
                        PetCardSummaryView(pet: pet, summarySource: .vaccines)
                    }
                }
                .foregroundColor(.primary)
                .padding()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("\(pet.name)'s Card")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingPetDetail) {
                PetDetailsView(pet: pet)
            }
            .sheet(isPresented: $showingChipID) {
                MicrochipView(pet: pet)
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit", action: showPetDetailsView)
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
    PetCardView(pet: SampleData.shared.petWithChipID)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}

#Preview("Pet with expired vaccines") {
    PetCardView(pet: SampleData.shared.petWithExpiredVaccines)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}

#Preview("Pet without weight") {
    PetCardView(pet: SampleData.shared.petWithoutSpecies)
        .modelContainer(SampleData.shared.modelContainer)
        .environmentObject(PetsStoreManager())
}

struct PetFeature: View {
    
    let feature: String
    let value: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(feature)
                .font(.callout.smallCaps())
                .foregroundStyle(.accent)
            
            Text(value.isEmpty ? "Unknown" : value)
                .font(feature == "Age" ? .title : .largeTitle)
                .bold()
                .fontDesign(.serif)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer()
        }
    }
}
