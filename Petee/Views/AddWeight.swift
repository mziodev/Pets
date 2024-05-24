//
//  AddWeight.swift
//  Petee
//
//  Created by Mauricio dSR on 24/5/24.
//

import SwiftUI

struct AddWeight: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State private var date = Date.now
    @State private var weight = ""
    
    @FocusState private var isWeightTextFieldFocused
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Add weight") {
                    DatePicker(
                        "Date",
                        selection: $date,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(.placeholder)
                    
                    TextField("kg", text: $weight)
                        .multilineTextAlignment(.trailing)
                        .focused($isWeightTextFieldFocused)
                        .keyboardType(.decimalPad)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let weightFloatValue = Float(weight) ?? 0
                        let newWeight = Weight(date: date, value: weightFloatValue)
                        
                        pet.weights.append(newWeight)
                        
                        dismiss()
                    }
                }
            }
            .onAppear {
                isWeightTextFieldFocused = true
            }
        }
    }
}

#Preview {
    AddWeight(pet: SampleData.shared.pet)
}
