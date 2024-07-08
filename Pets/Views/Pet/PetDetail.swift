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
    
    private var chipIDNumberPlaceholderText: String {
        switch pet.chipID.type {
        case .noChipID:
            ""
        case .fifteenDigit:
            String(localized: "ID number (15 numeric digits)")
        case .tenDigit:
            String(localized: "ID number (10 alphanumeric digits)")
        case .nineDigit:
            String(localized: "ID number (9 numeric digits)")
        }
    }
    private var isNameVerified: Bool {
        FormVerification.checkMinimumLength(pet.name)
    }
    private var isChipIDVerified: Bool {
        Pet.chipIDValidators[pet.chipID.type]?(pet.chipID.number) ?? false
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
                Form {
                    Section {
                        PetDetailImage(pet: pet)
                    }
                    .listRowBackground(Color.clear)
                    
                    Section("Basics") {
                        TextField("Name", text: $pet.name)
                            .focused($nameTextFieldFocused)
                            .overlay {
                                VerificationCheckMark(condition: isNameVerified)
                            }
                        
                        Picker("Species", selection: $pet.species) {
                            ForEach(PetSpecies.allCases, id: \.self) { species in
                                Text(species.localizedDescription)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Picker("Sex", selection: $pet.sex) {
                            ForEach(PetSex.allCases, id: \.self) { sex in
                                Text(sex.localizedDescription)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    Section("Breed") {
                        NavigationLink {
                            PetBreedList(pet: pet)
                        } label: {
                            Text(
                                pet.breed.isEmpty ? 
                                String(localized: "Select a breed") : pet.breed
                            )
                            .foregroundStyle(
                                pet.breed.isEmpty ? .gray.opacity(0.7) : .primary
                            )
                        }
                    }
                    
                    Section("Dates") {
                        Toggle("Adopted", isOn: $pet.isAdopted.animation())
                            .tint(.petsAccentBlue)
                        
                        DatePicker(
                            "Birthday",
                            selection: $pet.birthday,
                            in: Date.distantPast ... .now,
                            displayedComponents: .date
                        )
                        
                        DatePicker(
                            pet.isAdopted ? "Adopted on" : "On family since",
                            selection: $pet.onFamilySince,
                            in: pet.birthday ... .now,
                            displayedComponents: .date
                        )
                    }
                    
                    Section("Chip") {
                        Picker("ID type", selection: $pet.chipID.type.animation()) {
                            ForEach(ChipIDType.allCases, id: \.self) { type in
                                Text(type.localizedDescription)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        if pet.chipID.type != .noChipID {
                            TextField(
                                chipIDNumberPlaceholderText,
                                text: $pet.chipID.number
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .focused($chipTextFieldFocused)
                            .onChange(of: pet.chipID.type) { oldValue, newValue in
                                chipTextFieldFocused = true
                            }
                            .overlay {
                                VerificationCheckMark(
                                    condition: isChipIDVerified
                                )
                            }
                            
                            DatePicker(
                                "Implanted on",
                                selection: $pet.chipID.implantedDate,
                                in: pet.birthday ... .now,
                                displayedComponents: .date
                            )
                            
                            TextField("Location", text: $pet.chipID.location)
                        }
                    }
                }
            }
            .navigationTitle(isNew ? String(localized: "New pet") : pet.name)
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
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

