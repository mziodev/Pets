//
//  PetChipID.swift
//  Pets
//
//  Created by MZiO on 1/7/24.
//

import SwiftUI

struct MicrochipInfo: View {
    @Environment(\.dismiss) var dismiss
    
    let pet: Pet
    
    @State private var showingChipIDNumberText: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("Type")
                            .font(.headline)
                            .foregroundStyle(.accent)
                        
                        Spacer()
                        
                        Text(pet.chipID.type.localizedDescription)
                    }
                    
                    HStack {
                        Text("Number")
                            .font(.headline)
                            .foregroundStyle(.accent)
                        
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
                            .tint(.petsFulvous)
                        }
                    }
                    
                    HStack {
                        Text("Implanted on")
                            .font(.headline)
                            .foregroundStyle(.accent)
                        
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
                            .foregroundStyle(.accent)
                        
                        Spacer()
                        
                        Text(pet.chipID.location)
                    }
                }
                
                if showingChipIDNumberText {
                    Section {
                        Text("Microchip number is been copied to the clipboard. Go to [https://petmaxx.com](https://www.petmaxx.com/) and paste it inside the 'Microchip Search' box.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Microchip Info")
            .navigationBarTitleDisplayMode(.inline)
            .listSectionSpacing(5)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok") { dismiss() }
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
    MicrochipInfo(pet: SampleData.shared.petWithChipID)
}
