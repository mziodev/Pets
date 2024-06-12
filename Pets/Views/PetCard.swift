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
    
    var currentWeight: Measurement<UnitMass>?
    
    init(pet: Pet) {
        self.pet = pet
        self.currentWeight = .init(value: pet.reverseSortedWeights.first?.value ?? 0, unit: .kilograms)
    }
    
    
    // MARK: - body
    var body: some View {
        VStack {
            PetImage(pet: pet, imageSize: .large)
        
            List {
                Section {
                    BreedInfo(breed: pet.breed)
                }
                .listRowSeparator(.hidden)
                
                Section {
                    AgeInfo(year: pet.age.first, month: pet.age.last)
                }
                .listRowSeparator(.hidden)
                
                Section {
                    NavigationLink {
                        WeightList(pet: pet)
                    } label: {
                        if currentWeight!.value == 0.0 {
                            AddWeightInfo()
                        } else {
                            WeightInfo(weight: currentWeight)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                
                Section {
                    if pet.chipID.isEmpty {
                        HStack {
                            Spacer()
                            
                            Text("-- No chip ID --")
                                .font(.headline.uppercaseSmallCaps())
                            
                            Spacer()
                        }
                    } else {
                        NavigationLink {
                            ChipBarcode(chipID: pet.chipID)
                        } label: {
                            ChipIDInfo(chipID: pet.chipID)
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
        }
        .navigationTitle(pet.name)
        .padding(.top)
        
        
        // MARK: - PetDetail sheet
        .sheet(isPresented: $showingPetDetail) {
            NavigationStack {
                PetDetail(pet: pet)
                    .interactiveDismissDisabled()
            }
        }
        
        
        // MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
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


// MARK: - breed info view
struct BreedInfo: View {
    let breed: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Breed")
                .font(.callout.smallCaps())
                .foregroundStyle(.tint)
            
            Text(breed)
                .font(.largeTitle.bold())
                .fontDesign(.serif)
                .minimumScaleFactor(0.5)
            
            Spacer()
        }
        .frame(height: 40)
    }
}


// MARK: - age info view
struct AgeInfo: View {
    let year: String?
    let month: String?
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(year ?? "")
                .font(.largeTitle.bold())
                .fontDesign(.serif)
            
            Text(month ?? "")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.tint)
                .padding(.top, 12)
            
            Spacer()
        }
        .frame(height: 50)
    }
}


// MARK: - add weight info view
struct AddWeightInfo: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("Add weight")
                .font(.callout)
                .foregroundStyle(.placeholder)
            
            Spacer()
        }
    }
}


// MARK: - weight info view
struct WeightInfo: View {
    let weight: Measurement<UnitMass>?
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("weight")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.tint)
            
            Text(weight?.formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .personWeight
                    )
                ) ?? "-"
            )
            .font(.largeTitle)
            .bold()
            .fontDesign(.serif)
            
            Spacer()
        }
        .frame(height: 50)
    }
}


//  MARK: - chip ID info view
struct ChipIDInfo: View {
    let chipID: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Chip ID")
                .font(.callout.smallCaps())
                .foregroundStyle(.tint)
            
            Text(chipID)
                .fontDesign(.serif)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}
