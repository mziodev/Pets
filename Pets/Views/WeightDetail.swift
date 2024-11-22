//
//  WeightDetail.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import SwiftUI

struct WeightDetail: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    @Bindable var pet: Pet
    
    @State var weight: Weight
    
    @State private var weightValue: Double?
    @State private var editingWeight = false
    @State private var petsStoreAdText = String(
        localized: "Unlock Weight Notes and some other features with Pets Premium."
    )
    
    @State private var showingPetsStore = false
    @State private var showingDeleteAlert = false
    @State private var showingWeightAlert = false
    
    @FocusState private var weightTextFieldFocused
    
    let isNew: Bool
    
    init(
        pet: Pet,
        weight: Weight = Weight(),
        isNew: Bool = false
    ) {
        self.pet = pet
        self.weight = weight
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Weight Data") {
                    DatePicker(
                        "Date",
                        selection: $weight.date,
                        in: pet.birthday ... .now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(.placeholder)
                    
                    HStack {
                        Text("\(Weight.units)")
                            .foregroundStyle(.placeholder)
                        
                        TextField(
                            "",
                            value: $weightValue,
                            format: .number
                        )
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($weightTextFieldFocused)
                        .onChange(
                            of: weightValue ?? 0
                        ) { oldValue, newValue in
                            if newValue <= 350.0 {
                                weight.value = newValue
                            } else {
                                showingWeightAlert = true
                            }
                        }
                    }
                }
                .disabled(!editingWeight)
                
                if petsStoreManager.isPremiumUnlocked {
                    Section("Notes") {
                        TextField(
                            "...",
                            text: $weight.notes,
                            axis: .vertical
                        )
                    }
                    .disabled(!editingWeight)
                }
                
                if !petsStoreManager.isPremiumUnlocked && editingWeight {
                    GoPremiumAd(
                        showingPetsStore: $showingPetsStore,
                        adText: petsStoreAdText
                    )
                }
                
                if !isNew && editingWeight {
                    RowDeleteButton(
                        title: String(localized: "Delete Weight"),
                        showingAlert: $showingDeleteAlert
                    )
                }
            }
            .navigationTitle(isNew ? "Add Weight" : "Weight Details")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                copyWeightValue()
                
                if isNew { editingWeight = true }
                
                weightTextFieldFocused = true
            }
            .sheet(isPresented: $showingPetsStore) { PetsStoreView() }
            .alert("Warning!", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel, action: { })
                Button("Ok", role: .destructive, action: deleteWeight)
            } message: {
                Text("This weight will be deleted, are you sure?")
            }
            .alert("Warning!", isPresented: $showingWeightAlert) {
                Button("Nooo!", role: .cancel, action: { })
                Button("Yes", role: .destructive, action: { })
            } message: {
                Text("Are you sure that \(pet.name) is \(String(format: "%.2f", weightValue ?? 0)) \(Weight.units)?")
            }
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: dismissView)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    if editingWeight {
                        Button("Save", action: appendWeight)
                            .disabled(weight.value <= 0)
                    } else {
                        Button("Edit", action: toggleEditigWeight)
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
    
    private func toggleEditigWeight() {
        withAnimation {
            editingWeight.toggle()
            weightTextFieldFocused.toggle()
        }
    }
    
    private func appendWeight() {
        pet.weights?.append(weight)
        
        dismiss()
    }
    
    private func deleteWeight() {
        if let weightIndex = pet.unwrappedWeights.firstIndex(where: {
            $0.id == weight.id
        }) {
            pet.weights?.remove(at: weightIndex)
        }
        
        dismiss()
    }
    
    private func copyWeightValue() {
        if weight.value > 0 { weightValue = self.weight.value }
    }
}


#Preview("New weight") {
    WeightDetail(pet: SampleData.shared.petWithChipID, isNew: true)
        .environmentObject(PetsStoreManager())
}

#Preview("Existing weight") {
    WeightDetail(
        pet: SampleData.shared.petWithChipID,
        weight: Weight.sampleData[0]
    )
    .environmentObject(PetsStoreManager())
}
