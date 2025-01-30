//
//  PetChipID.swift
//  Pets
//
//  Created by MZiO on 1/7/24.
//

import SwiftUI

struct MicrochipView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let pet: Pet
    
    @State private var showingMicrochipCopiedText = false
    
    private func copyMicrochipNumber() {
        UIPasteboard.general.string = pet.chipID.number
        
        withAnimation {
            showingMicrochipCopiedText = true
        }
    }
    
    private func dismissView() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    HStack {
                        Text("Type")
                            .foregroundStyle(.accent)
                        
                        Spacer()
                        
                        Text(pet.chipID.type.localizedDescription)
                    }
                    
                    HStack {
                        Text("Number")
                            .foregroundStyle(.accent)
                        
                        Spacer()
                        
                        HStack {
                            Text(pet.chipID.number)
                            
                            Button(action: copyMicrochipNumber) {
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
                            .foregroundStyle(.accent)
                        
                        Spacer()
                        
                        Text(pet.chipID.location)
                    }
                } header: {
                    Text("Info")
                } footer: {
                    if showingMicrochipCopiedText {
                        Text("Microchip number is been copied to the clipboard. Go to [https://petmaxx.com](https://www.petmaxx.com/) and paste it inside the 'Microchip Search' box.")
                    }
                }
            }
            .navigationTitle("\(pet.name)'s Microchip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
}

#Preview {
    MicrochipView(pet: SampleData.shared.petWithChipID)
}
