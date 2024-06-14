//
//  AddWeight.swift
//  Petee
//
//  Created by Mauricio dSR on 24/5/24.
//

import SwiftUI

struct WeightDetail: View {
    @Environment(\.dismiss) var dismiss
//    @Environment(\.modelContext) var modelContext
    
    @Bindable var pet: Pet
    
    @State private var date = Date.now
    @State private var value = ""
    
    @FocusState private var isWeightTextFieldFocused
    
    
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
            }
            .navigationTitle("Add weight")
            .navigationBarTitleDisplayMode(.inline)
            
            
            // MARK: - onAppear
            .onAppear {
                isWeightTextFieldFocused = true
            }
            
            
            // MARK: - toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", action: saveWeight)
                }
            }
        }
    }
    
    
    // MARK: - functions
    func saveWeight() {
        pet.weights.append(Weight(date: date, value: Double(value) ?? 0))
        
        dismiss()
    }
}


// MARK: - previews
#Preview {
    WeightDetail(pet: SampleData.shared.petWithChipID)
}
