//
//  AddPet.swift
//  Petee
//
//  Created by MZiO on 25/5/24.
//

import PhotosUI
import SwiftData
import SwiftUI


struct AddPet: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var pet = Pet()
    

    // MARK: - state pet properties
    @State var species = PetSpecies.canine
    @State var sex = PetSex.female
    @State var name = ""
    @State var breed = ""
    @State var birthday = Date.now
    @State var onFamilySince = Date.now
    @State var chipIDType: ChipIDType = .fifteenDigits
    @State var chipID = ""
    @State var isAdopted = false
    @State var image: Data?
    @State var selectedImage: PhotosPickerItem?
    
    
    // MARK: - body
    var body: some View {
        VStack {
            VStack {
                if let imageData = image,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())

                } else {
                    PlaceholderPetImage(petSpecies: species)
                }
                
                PhotosPicker(
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text(image != nil ? "Change photo" : "Add photo")
                }
                
                if image != nil {
                    Button("Remove photo", role: .destructive) {
                        withAnimation {
                            selectedImage = nil
                            image = nil
                        }
                    }
                }
            }
            
            
            // MARK: - form
            Form {
                Section("Basic info") {
                    Picker("Species", selection: $species) {
                        ForEach(PetSpecies.allCases, id: \.self) { species in
                            Text(species.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Sex", selection: $sex) {
                        ForEach(PetSex.allCases, id: \.self) { sex in
                            Text(sex.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Name", text: $name)
                }
                
                Section("Breed") {
                    TextField("Breed", text: $breed)
                    
                    Toggle("Adopted", isOn: $isAdopted.animation())
                        .tint(.accentColor)
                }
                
                Section("Chip") {
                    Picker("Chip ID type", selection: $chipIDType) {
                        ForEach(ChipIDType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .disabled(!chipID.isEmpty)
                    .pickerStyle(.navigationLink)
                    
                    TextField("Chip ID", text: $chipID)
                }
                
                Section("Dates") {
                    DatePicker(
                        "Born on",
                        selection: $birthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        isAdopted ? "Adopted on" : "On the family since",
                        selection: $onFamilySince,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                }
            }
        }
        .navigationTitle("New pet")
        .navigationBarTitleDisplayMode(.inline)
        
        
        // MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    let newPet = Pet(
                        species: species,
                        sex: sex,
                        name: name,
                        breed: breed,
                        chipID: chipID,
                        adopted: isAdopted,
                        birthday: birthday,
                        onFamilySince: onFamilySince,
                        image: image
                    )
                    
                    modelContext.insert(newPet)
                    
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
        }
        .task(id: selectedImage) {
            if let data = try? await selectedImage?.loadTransferable(
                type: Data.self
            ) {
                image = data
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPet()
    }
}