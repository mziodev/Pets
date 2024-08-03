//
//  WeightInputTest.swift
//  Pets
//
//  Created by MZiO on 2/8/24.
//

import SwiftUI

struct WeightInputTest: View {
    @State private var valueTextField = "0.00"
    @State private var weightTextField: Double?
    @FocusState private var valueTextFieldFocused: Bool

    var body: some View {
            Form {
                HStack(spacing: 3) {
                    TextField("Value", text: $valueTextField)
                        .focused($valueTextFieldFocused)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: valueTextField) {
                            oldValue,
                            newValue in
                            valueTextField = Format.formatValueAsCurrencyRightToLeft(
                                value: newValue
                            )
                        }
                        .onAppear {
                            valueTextFieldFocused = true
                    }
                    
                    Text(Weight.units)
                }
                
                HStack(spacing: 3) {
                    Text(Weight.units)
                    
                    TextField(
                        "Weight",
                        value: $weightTextField,
                        format: .number
                    )
                    .focused($valueTextFieldFocused)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .onAppear {
                        valueTextFieldFocused = true
                    }
                }
            }
        }
}

#Preview {
    WeightInputTest()
}
