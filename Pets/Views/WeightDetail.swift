//
//  AddWeight.swift
//  Petee
//
//  Created by MZiO on 24/5/24.
//

import SwiftUI

struct WeightDetail: View {
    @Environment(\.dismiss) var dismiss
//    @Environment(\.modelContext) var modelContext
    
    @Bindable var pet: Pet
    
    @State private var date = Date.now
    @State private var value = ""
    
    @FocusState private var isWeightTextFieldFocused
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker(
                    "Date",
                    selection: $date,
                    in: Date.distantPast...Date.now,
                    displayedComponents: .date
                )
                .foregroundStyle(.placeholder)
                
                TextField("\(Weight.units)", text: $value)
                    .multilineTextAlignment(.trailing)
                    .focused($isWeightTextFieldFocused)
                    .keyboardType(.decimalPad)
                    .onChange(of: value) { oldValue, newValue in
                        value = newValue.replacingOccurrences(
                            of: ",",
                            with: "."
                        )
                    }
            }
            .navigationTitle("Add weight")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .onAppear { isWeightTextFieldFocused = true }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: appendWeight)
                        .disabled(value.isEmpty)
                }
            }
        }
    }

    func appendWeight() {
        pet.weights.append(Weight(date: date, value: Double(value) ?? 0))
        dismiss()
    }
}

#Preview {
    WeightDetail(pet: SampleData.shared.petWithChipID)
}
