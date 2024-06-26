//
//  AddWeight.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import SwiftUI

struct WeightDetail: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var weight: Weight
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
                    DatePicker(
                        "Date",
                        selection: $weight.date,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(.placeholder)
                    
                    HStack {
                        Text("Weight")
                            .foregroundStyle(.placeholder)
                        
                        TextField("", value: $weight.value, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .focused($isWeightTextFieldFocused)
                        
                        Text("\(Weight.units)")
                    }
                }
                
                if !isNew {
                    Button("Delete weight", role: .destructive) {
                        showingDeleteAlert = true
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle(isNew ? "Add Weight" : "Edit Weight")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .onAppear {
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
                    Button("Save", action: appendWeight)
                        .disabled(weight.value <= 0)
                }
            }
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
}


#Preview("New weight") {
    WeightDetail(pet: SampleData.shared.petWithChipID, isNew: true)
}

#Preview("Existing weight") {
    WeightDetail(pet: SampleData.shared.petWithChipID, weight: Weight.sampleData[0])
}
