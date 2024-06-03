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


// MARK: - format kg style
let formatStyle = Measurement<UnitMass>.FormatStyle(
    width: .abbreviated,
    numberFormatStyle: .number
)

struct PetDetail: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var selectedImage: PhotosPickerItem?
    
    let isNew: Bool
    
    @FocusState var nameTextFieldFocused: Bool
    
    
    // Mark: - init
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
                            Text(species.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Sex", selection: $pet.sex) {
                        ForEach(PetSex.allCases, id: \.self) { sex in
                            Text(sex.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Name", text: $pet.name)
                        .focused($nameTextFieldFocused)
                }
                
                Section("Breed") {
                    TextField("Breed", text: $pet.breed)
                }
                
                Section("Chip") {
                    Picker("ID type", selection: $pet.chipIDType.animation()) {
                        ForEach(ChipIDType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    if pet.chipIDType != .noChipID {
                        TextField("ID number", text: $pet.chipID)
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
                } else {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
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

