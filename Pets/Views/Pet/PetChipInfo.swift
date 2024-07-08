//
//  PetChipID.swift
//  Pets
//
//  Created by MZiO on 1/7/24.
//

import SwiftUI

struct PetChipInfo: View {
    @Environment(\.dismiss) var dismiss
    
    let pet: Pet
    
    @State private var showingChipIDNumberText: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        HStack {
                            Text("Type")
                                .font(.headline)
                                .foregroundStyle(.petsAccentBlue)
                            
                            Spacer()
                            
                            Text(pet.chipID.type.localizedDescription)
                        }
                        
                        HStack {
                            Text("Number")
                                .font(.headline)
                                .foregroundStyle(.petsAccentBlue)
                            
                            Spacer()
                            
                            HStack {
                                Text(pet.chipID.number)
                                
                                Button(action: copyChipIDNumber) {
                                    Label(
                                        "Copy chip ID number",
                                        systemImage: "doc.on.doc"
                                    )
                                    .labelStyle(.iconOnly)
                                }
                            }
                        }
                        
                        HStack {
                            Text("Implanted on")
                                .font(.headline)
                                .foregroundStyle(.petsAccentBlue)
                            
                            Spacer()
                            
                            Text(
                                pet.chipID.implantedDate.formatted(
                                    date: .abbreviated,
                                    time: .omitted
                                )
                            )
                        }
                        
                        HStack {
                            Text("Location")
                                .font(.headline)
                                .foregroundStyle(.petsAccentBlue)
                            
                            Spacer()
                            
                            Text(pet.chipID.location)
                        }
                    }
                    
                    if showingChipIDNumberText {
                        Section {
                            Text("**Chip ID** number is been copied to the clipboard. Go to [https://petmaxx.com](https://www.petmaxx.com/) and paste it inside the 'Microchip Search' box.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listSectionSpacing(5)
            }
            .navigationTitle("Chip ID Info")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func copyChipIDNumber() {
        UIPasteboard.general.string = pet.chipID.number
        withAnimation { showingChipIDNumberText = true }
    }
}

#Preview {
    PetChipInfo(pet: SampleData.shared.petWithChipID)
}
