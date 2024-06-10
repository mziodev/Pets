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
                        WeightInfo(weight: currentWeight)
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
        
        
        // MARK: - onAppear
        .onAppear {
        }
        
        
        // MARK: - PetDetail sheet
        .sheet(isPresented: $showingPetDetail) {
            NavigationStack {
                PetDetail(pet: pet)
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


// MARK: - extracted views
struct BreedInfo: View {
    let breed: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Breed")
                .font(.callout.smallCaps())
                .foregroundStyle(.tint)
                .padding(.top, 8)
            
            Text(breed)
                .font(.largeTitle.bold())
                .fontDesign(.serif)
            
            Spacer()
        }
        .frame(height: 40)
    }
}

struct AgeInfo: View {
    let year: String?
    let month: String?
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            Text(year ?? "")
                .font(.largeTitle)
                .fontDesign(.serif)
                .bold()
            
            Text(month ?? "")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.tint)
                .padding(.bottom, 5)
            
            Spacer()
        }
        .frame(height: 50)
    }
}

struct WeightInfo: View {
    let weight: Measurement<UnitMass>?
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            Text("weight")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.tint)
                .padding(.bottom, 4)
            
            Text(
                weight?.formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .personWeight
                    )
                ) ?? "No weight yet"
            )
                .font(.largeTitle)
                .bold()
                .fontDesign(.serif)
            
            Spacer()
        }
        .frame(height: 50)
    }
}

struct ChipIDInfo: View {
    let chipID: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Chip ID")
                .font(.callout.smallCaps())
                .foregroundStyle(.tint)
                .padding(.top, 1)
            
            Text(chipID)
                .fontDesign(.serif)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}
