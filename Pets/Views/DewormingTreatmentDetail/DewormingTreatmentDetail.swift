//
//  DewormingDetail.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftData
import SwiftUI

struct DewormingTreatmentDetail: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var dewormingTreatment: DewormingTreatment
    
    let isNew: Bool
    
    private var isNameVerified: Bool {
        FormVerification.checkMinimumLength(dewormingTreatment.name)
    }
    private var isQuantityVerified: Bool {
        dewormingTreatment.quantity > 0
    }
    private var isFormVerified: Bool {
        isNameVerified && isQuantityVerified
    }
    
    
    init(
        pet: Pet,
        dewormingTreatment: DewormingTreatment = DewormingTreatment(),
        isNew: Bool = false
    ) {
        self.pet = pet
        self.dewormingTreatment = dewormingTreatment
        self.isNew = isNew
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Label(
                    dewormingTreatment.type.rawValue,
                    systemImage: dewormingTreatment.type.systemImage
                )
                .labelStyle(.iconOnly)
                .font(.system(size: 70))
                .padding(.top)
                .foregroundStyle(.tint)
                
                Text("\(pet.name)'s deworming treatment")
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
                                    
                                    TextField(
                                        "",
                                        value: $dewormingTreatment.quantity,
                                        format: .number
                                    )
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(.trailing, 30)
                            .overlay {
                                VerificationCheckMark(condition: isQuantityVerified)
                            }
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
                
                if !isNew {
                    Button(
                        "Delete treatment",
                        role: .destructive,
                        action: deleteDewormingTreatment
                    )
                    .padding(.top, 5)
                }
            }
            .navigationTitle("Deworming details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: appendDewormingTreatment)
                        .disabled(!isFormVerified)
                }
                
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
            }
        }
    }
    
    
    private func appendDewormingTreatment() {
        pet.dewormingTreatments.append(dewormingTreatment)
        dismiss()
    }
    
    private func deleteDewormingTreatment() {
        if let dewormingTreatmentIndex = pet.dewormingTreatments.firstIndex(where: { $0.id == dewormingTreatment.id }) {
            pet.dewormingTreatments.remove(at: dewormingTreatmentIndex)
            dismiss()
        }
    }
}


#Preview("New deworming") {
    DewormingTreatmentDetail(
        pet: SampleData.shared.petWithChipID,
        isNew: true
    )
}

#Preview("Existing deworming") {
    DewormingTreatmentDetail(
        pet: SampleData.shared.petWithChipID,
        dewormingTreatment: SampleData.shared.petWithChipID.dewormingTreatments[0]
    )
}
