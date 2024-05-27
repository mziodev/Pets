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
    
    // MARK: - state pet properties
    @State var pet = Pet()
    
    @State var species = PetSpecies.canine
    @State var sex = PetSex.female
    @State var name = ""
    @State var breed = ""
    @State var birthday = Date.now
    @State var onFamilySince = Date.now
    @State var adopted = false
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
                    GenericPetImage(petSpecies: species)
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
                    
                    Toggle("Adopted", isOn: $adopted.animation())
                        .tint(.accentColor)
                }
                
                Section("Dates") {
                    DatePicker(
                        "Born on",
                        selection: $birthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        adopted ? "Adopted on" : "On the family since",
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
                        adopted: adopted,
                        birthday: birthday,
                        onFamilySince: onFamilySince,
                        image: image
                    )
                    
                    modelContext.insert(newPet)
                    
                    dismiss()
                }
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
