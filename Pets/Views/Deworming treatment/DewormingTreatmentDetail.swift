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
    
    @State private var treatmentQuantity: Double?
    @State private var editingTreatment: Bool = false
    @State private var showingDeleteAlert: Bool = false
    
    @FocusState private var treatmentNameTextFieldFocused: Bool
    
    let isNew: Bool
    
    private var isNameVerified: Bool {
        dewormingTreatment.name.hasMinimumLength()
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
            Form {
                Section {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Label(
                                dewormingTreatment.type.rawValue,
                                systemImage: dewormingTreatment.type.systemImage
                            )
                            .labelStyle(.iconOnly)
                            .font(.system(size: 70))
                            .foregroundStyle(.petsAccentBlue)
                            
                            Text("\(pet.name)'s deworming treatment")
                                .font(.title3)
                                .padding(.top)
                        }
                        
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                Section("Info") {
                    TextField(
                        "Treatment name",
                        text: $dewormingTreatment.name
                    )
                    .focused($treatmentNameTextFieldFocused)
                    .overlay {
                        VerificationCheckMark(condition: isNameVerified)
                    }
                    
                    Picker(
                        "Treatment type",
                        selection: $dewormingTreatment.type.animation()
                    ) {
                        ForEach(
                            TreatmentType.allCases,
                            id: \.self
                        ) { type in
                            Text(type.localizedDescription)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker(selection: $dewormingTreatment.units) {
                        ForEach(
                            TreatmentUnit.allCases,
                            id:\.self
                        ) { units in
                            Text(units.localizedDescription)
                        }
                    } label: {
                        HStack {
                            Text("Quantity")
                            
                            TextField(
                                "Quantity",
                                value: $treatmentQuantity,
                                format: .number
                            )
                            .multilineTextAlignment(.trailing)
                            .onChange(
                                of: treatmentQuantity ?? 0
                            ) { oldValue, newValue in
                                dewormingTreatment.quantity = newValue
                            }
                            .keyboardType(.decimalPad)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.trailing, 30)
                    .overlay {
                        VerificationCheckMark(
                            condition: isQuantityVerified
                        )
                    }
                }
                
                Section("Dates") {
                    DatePicker(
                        "Starts",
                        selection: $dewormingTreatment.startingDate,
                        in: pet.birthday ... .now,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        "Ends",
                        selection: $dewormingTreatment.endingDate,
                        in: pet.birthday ... .distantFuture,
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
                
                if !isNew {
                    RowDeleteButton(
                        title: "Delete Treatment",
                        showingAlert: $showingDeleteAlert
                    )
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(isNew ? "Add Treatment" : "Treatment Details")
            .disabled(!editingTreatment)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                copyDewormingTreatmentQuantity()
                
                if isNew { editingTreatment = true }
                
                treatmentNameTextFieldFocused = true
            }
            .alert("Warning!", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel, action: { })
                Button(
                    "Ok",
                    role: .destructive,
                    action: deleteDewormingTreatment
                )
            } message: {
                Text("Deworming treatment will deleted, are you sure?")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    if editingTreatment {
                        Button("Save", action: appendDewormingTreatment)
                            .disabled(!isFormVerified)
                    } else {
                        Button("Edit", action: toggleEditingTreatment)
                    }
                }
                
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: dismissView)
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
    
    private func toggleEditingTreatment() {
        withAnimation {
            editingTreatment.toggle()
            treatmentNameTextFieldFocused.toggle()
        }
    }
    
    private func appendDewormingTreatment() {
        pet.dewormingTreatments?.append(dewormingTreatment)
        
        dismiss()
    }
    
    private func deleteDewormingTreatment() {
        if let dewormingTreatmentIndex = pet.unwrappedDewormingTreatments.firstIndex(where: {
            $0.id == dewormingTreatment.id
        }) {
            pet.dewormingTreatments?.remove(at: dewormingTreatmentIndex)
            
            dismiss()
        }
    }
    
    private func copyDewormingTreatmentQuantity() {
        if dewormingTreatment.quantity > 0 {
            treatmentQuantity = dewormingTreatment.quantity
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
        dewormingTreatment: SampleData.shared.petWithChipID.unwrappedDewormingTreatments[0]
    )
}
