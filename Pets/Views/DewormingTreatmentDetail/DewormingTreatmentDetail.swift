//
//  DewormingDetail.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

/*
 TODO
 Change quantity textfield type to String and turn all commas appearences for dots, then turn it into a Double.
 */

import SwiftData
import SwiftUI

struct DewormingTreatmentDetail: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var dewormingTreatment: DewormingTreatment
    
    let isNew: Bool
    
    private var isNameVerified: Bool {
        FormVerification.checkMinimumLength(dewormingTreatment.name)
    }
    private var isQuantityVerified: Bool {
        dewormingTreatment.quantity > 0
    }
    
    init(dewormingTreatment: DewormingTreatment, isNew: Bool = false) {
        self.dewormingTreatment = dewormingTreatment
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Label(
                dewormingTreatment.type.rawValue,
                systemImage: dewormingTreatment.type.systemImage
            )
            .labelStyle(.iconOnly)
            .font(.system(size: 70))
            .padding(.top)
            .foregroundStyle(.tint)
            
            Text("\(dewormingTreatment.pet!.name)'s deworming treatment")
                .font(.title3)
                .padding(.top)
            
            Form {
                Section("Info") {
                    TextField("Treatment name", text: $dewormingTreatment.name)
                        .font(.title3.smallCaps())
                        .overlay {
                            VerificationCheckMark(condition: isNameVerified)
                        }
                    
                    Picker("Treatment type", selection: $dewormingTreatment.type.animation()) {
                        ForEach(TreatmentType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack {
                        Picker(selection: $dewormingTreatment.units) {
                            ForEach(TreatmentUnits.allCases, id:\.self) { units in
                                Text(units.rawValue)
                            }
                        } label: {
                            HStack {
                                Text("Quantity")
                                    .foregroundStyle(.placeholder)
                                
                                TextField(
                                    "",
                                    value: $dewormingTreatment.quantity,
                                    format: .number
                                )
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                
                                VerificationCheckMark(condition: isQuantityVerified)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                Section("Dates") {
                    DatePicker(
                        "Start",
                        selection: $dewormingTreatment.startingDate,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        "Ends",
                        selection: $dewormingTreatment.endingDate,
                        displayedComponents: .date
                    )
                }
                
                Section("Notes") {
                    TextField(
                        "...",
                        text: $dewormingTreatment.notes,
                        axis: .vertical
                    )
                }
            }
            .navigationTitle("Deworming details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isNew {
                    ToolbarItem {
                        Button("Save", action: saveDewormingTreatment)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) { dismiss() }
                    }
                } else {
                    ToolbarItem {
                        Button("Done") { dismiss() }
                    }
                }
            }
        }
    }
    
    
    private func saveDewormingTreatment() {
//        modelContext.insert(dewormingTreatment)
        dewormingTreatment.pet?.dewormingTreatments.append(dewormingTreatment)
        dismiss()
    }
}


#Preview("New deworming") {
    DewormingTreatmentDetail(
        dewormingTreatment: DewormingTreatment(
            pet: SampleData.shared.petWithChipID
        ),
        isNew: true
    )
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Existing deworming") {
    DewormingTreatmentDetail(
        dewormingTreatment: DewormingTreatment.sampleData[3]
    )
    .modelContainer(SampleData.shared.modelContainer)
}
