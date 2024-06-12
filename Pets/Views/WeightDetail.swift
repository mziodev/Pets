//
//  AddWeight.swift
//  Petee
//
//  Created by Mauricio dSR on 24/5/24.
//

import SwiftUI

struct WeightDetail: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State private var date = Date.now
    @State private var value = ""
    
    @FocusState private var isWeightTextFieldFocused
    
    let isNew = false
    
    
    // MARK: - body
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker(
                        "Date",
                        selection: $date,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(.placeholder)
                    
                    TextField("Kg", text: $value)
                        .multilineTextAlignment(.trailing)
                        .focused($isWeightTextFieldFocused)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(isNew ? "New weight" : "Edit weight")
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - onAppear
            .onAppear {
                isWeightTextFieldFocused = true
            }
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let doubleValue = Double(value) ?? 0
                        let newWeight = Weight(date: date, value: doubleValue)
                        
                        pet.weights.append(newWeight)
                        
                        dismiss()
                    }
                }
            }
        }
    }
    
    func convertToDouble(_ value: String) -> Double? {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.number(from: value)?.doubleValue
    }
}


// MARK: - previews

#Preview {
    WeightDetail(pet: SampleData.shared.petWithChipID)
}
