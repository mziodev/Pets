//
//  PetDetail.swift
//  Pets
//
//  Created by MZiO on 20/5/24.
//

import PhotosUI
import SwiftData
import SwiftUI


struct PetDetail: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @FocusState var nameTextFieldFocused: Bool
    @FocusState var chipTextFieldFocused: Bool
    
    let isNew: Bool

    private var isNameVerified: Bool {
        FormVerification.checkMinimumLength(pet.name)
    }
    private var isChipIDVerified: Bool {
        Pet.chipIDValidators[pet.chipIDType]?(pet.chipID) ?? false
    }
    private var isFormVerified: Bool {
        isNameVerified && isChipIDVerified
    }
    

    init(pet: Pet, isNew: Bool = false) {
        self.pet = pet
        self.isNew = isNew
    }
    

    var body: some View {
        NavigationStack {
            VStack {
                PetDetailImage(pet: pet)
                
                Form {
                    Section("Basics") {
                        TextField("Name (min. 2 characters)", text: $pet.name)
                            .focused($nameTextFieldFocused)
                            .overlay {
                                VerificationCheckMark(condition: isNameVerified)
                            }
                        
                        Picker("Species", selection: $pet.species) {
                            ForEach(PetSpecies.allCases, id: \.self) { species in
                                Text(species.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Picker("Sex", selection: $pet.sex) {
                            ForEach(PetSex.allCases, id: \.self) { sex in
                                Text(sex.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    Section("Breed") {
                        NavigationLink {
                            PetBreedList(pet: pet)
                        } label: {
                            Text(pet.breed.isEmpty ? "Select a breed" : pet.breed)
                                .foregroundStyle(
                                    pet.breed.isEmpty ? .gray.opacity(0.7) : .primary
                                )
                        }
                    }
                    
                    Section("Chip") {
                        Picker("ID type", selection: $pet.chipIDType.animation()) {
                            ForEach(ChipIDType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: pet.chipIDType) { oldValue, newValue in
                            chipTextFieldFocused = true
                        }
                        
                        if pet.chipIDType != .noChipID {
                            TextField(
                                pet.chipIDType == .fifteenDigits ? "ID number (exactly 15 digits)" : "ID number (exactly 9 digits)",
                                text: $pet.chipID
                            )
                            .keyboardType(.numberPad)
                            .focused($chipTextFieldFocused)
                            .overlay {
                                VerificationCheckMark(
                                    condition: isChipIDVerified
                                )
                            }
                        }
                    }
                    
                    Section("Dates") {
                        DatePicker(
                            "Born on",
                            selection: $pet.birthday,
                            in: Date.distantPast...Date.now,
                            displayedComponents: .date
                        )
                        
                        DatePicker(
                            pet.isAdopted ? "Adopted on" : "On the family since",
                            selection: $pet.onFamilySince,
                            in: pet.birthday...Date.now,
                            displayedComponents: .date
                        )
                    }
                }
            }
            .navigationTitle(isNew ? "New pet" : pet.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
            .interactiveDismissDisabled()
            .onAppear {
                if pet.name.isEmpty { nameTextFieldFocused = true }
            }
            .toolbar {
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button("Save") {
                            modelContext.insert(pet)
                            
                            dismiss()
                        }
                        .disabled(!isFormVerified)
                    }
                } else {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Done") { dismiss() }
                            .disabled(!isFormVerified)
                    }
                }
            }
        }
    }
}


#Preview("New pet") {
    PetDetail(pet: Pet(), isNew: true)
}

#Preview("Existing pet") {
    PetDetail(pet: SampleData.shared.petWithChipID)
}

