//
//  PetDetail.swift
//  Pets
//
//  Created by MZiO on 20/5/24.
//

/*
 TODO:
 
    Add button for showing add menu: weight, vaccine, parasites, vet consultations...
 */

import PhotosUI
import SwiftData
import SwiftUI


struct PetDetail: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var selectedImage: PhotosPickerItem?
    @FocusState var nameTextFieldFocused: Bool
    
    let isNew: Bool
    
    // MARK: - form validation logic
    private var isNameVerified: Bool {
        checkMinimumLength(pet.name)
    }
    private var isChipIDVerified: Bool {
        Pet.chipIDValidators[pet.chipIDType]?(pet.chipID) ?? false
    }
    private var isFormVerified: Bool {
        isNameVerified && isChipIDVerified
    }
    
    
    //  MARK: - init
    init(pet: Pet, isNew: Bool = false) {
        self.pet = pet
        self.isNew = isNew
    }
    
    
    // MARK: - body
    var body: some View {
        VStack {
            
            
            // MARK: - pet image
            VStack {
                PetImage(pet: pet, imageSize: .small)
                
                PhotosPicker(
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text(pet.image != nil ? "Change photo" : "Add photo")
                        .foregroundStyle(
                            pet.image != nil ? .primary : Color.accentColor
                        )
                }
                
                if pet.image != nil {
                    Button("Remove photo", role: .destructive) {
                        withAnimation {
                            selectedImage = nil
                            pet.image = nil
                        }
                    }
                }
            }
            
            
            // MARK: - form
            Form {
                Section("Basic info") {
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
                    
                    TextField("Name (min. 2 characters)", text: $pet.name)
                        .focused($nameTextFieldFocused)
                        .overlay {
                            VerifiedCheckMark(condition: isNameVerified)
                        }
                }
                
                Section("Breed") {
//                    TextField("Breed", text: $pet.breed)
                    NavigationLink {
                        PetBreedList(pet: pet)
                    } label: {
                        Text(pet.breed.isEmpty ? "Select a breed" : pet.breed)
                            .foregroundStyle(
                                pet.breed.isEmpty ? .gray.opacity(0.7) : .primary)
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
                        if newValue == .noChipID { pet.chipID = "" }
                    }
                    
                    if pet.chipIDType != .noChipID {
                        TextField(
                            pet.chipIDType == .fifteenDigits ? "ID number (exactly 15 digits)" : "ID number (exactly 9 digits)",
                            text: $pet.chipID
                        )
                        .overlay {
                            VerifiedCheckMark(
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
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                }
            }
        }
        .navigationTitle(isNew ? "New pet" : pet.name)
        .navigationBarTitleDisplayMode(.inline)
        
        
        // MARK: - load image task
        .task(id: selectedImage) {
            if let data = try? await selectedImage?.loadTransferable(
                type: Data.self
            ) {
                pet.image = data
            }
        }
        
        
        // MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                if isNew {
                    Button("Save") {
                        modelContext.insert(pet)
                        
                        dismiss()
                    }
                    .disabled(!isFormVerified)
                } else {
                    Button("Done") { dismiss() }
                        .disabled(!isFormVerified)
                }
            }
        }
    }
    
    
    // MARK: functions
    /// Checks if the given string has a minimum length of 2 characters.
    ///
    /// - Parameter name: The string to check.
    /// - Returns: `true` if the string has a minimum length of 2 characters, `false` otherwise.
    func checkMinimumLength(_ name: String) -> Bool { name.count > 1 }
}


// MARK: - previews
#Preview("New pet") {
    NavigationStack {
        PetDetail(pet: Pet(), isNew: true)
//            .environment(\.locale, Locale(identifier: "en_US"))
    }
}

#Preview("Existing pet") {
    NavigationStack {
        PetDetail(pet: SampleData.shared.petWithChipID)
//            .environment(\.locale, Locale(identifier: "en_US"))
    }
}

