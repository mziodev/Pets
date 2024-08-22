//
//  WeightDetail.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import SwiftUI

struct WeightDetail: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var weight: Weight
    @State private var weightValue: Double?
    @State private var editingWeight: Bool = false
    @State private var showingDeleteAlert: Bool = false
    
    @FocusState private var isWeightTextFieldFocused
    
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
            VStack {
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
                            .focused($isWeightTextFieldFocused)
                            .onChange(of: weightValue ?? 0) { oldValue, newValue in
                                weight.value = newValue
                            }
                        }
                    }
                }
                .disabled(!editingWeight)
                .scrollDismissesKeyboard(.immediately)
                
                if !isNew {
                    Button("Delete weight", role: .destructive) {
                        showingDeleteAlert = true
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle(isNew ? "Add Weight" : "Weight Details")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                copyWeightValue()
                
                if isNew { editingWeight = true }
                
                isWeightTextFieldFocused = true
            }
            .alert("Warning!", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel, action: { })
                Button("Ok", role: .destructive, action: deleteWeight)
            } message: {
                Text("This weight will be deleted, are you sure?")
            }
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if editingWeight {
                        Button("Save", action: appendWeight)
                            .disabled(weight.value <= 0)
                    } else {
                        Button("Edit", action: editWeight)
                    }
                }
            }
        }
    }

    
    private func editWeight() {
        withAnimation {
            editingWeight = true
        }
    }
    
    private func appendWeight() {
        pet.weights.append(weight)
        
        dismiss()
    }
    
    private func deleteWeight() {
        if let weightIndex = pet.weights.firstIndex(where: {
            $0.id == weight.id
        }) {
            pet.weights.remove(at: weightIndex)
        }
        
        dismiss()
    }
    
    private func copyWeightValue() {
        if weight.value > 0 { weightValue = self.weight.value }
    }
}


#Preview("New weight") {
    WeightDetail(pet: SampleData.shared.petWithChipID, isNew: true)
}

#Preview("Existing weight") {
    WeightDetail(pet: SampleData.shared.petWithChipID, weight: Weight.sampleData[0])
}
