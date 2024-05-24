//
//  PetDetail.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct PetDetail: View {
    @Bindable var pet: Pet
    
    @State var breed = ""
    @State var birthday = Date.now
    @State var onFamilySince = Date.now
    @State var selectedImage: PhotosPickerItem?
    @State var isFormDisabled = true
    @State var petInfo = ""
    
    private let compliments = [
        "handsome", "beautiful", "lovely", "nice", "good-looking", "cute", "pretty"
    ]
    
    
    // MARK: - body
    var body: some View {
        VStack {
            VStack {
                if let imageData = pet.image,
                    let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())

                } else {
                    GenericPetImage(petSpecies: pet.type)
                }
                
                if !isFormDisabled {
                    PhotosPicker(
                        selection: $selectedImage,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Text(pet.image != nil ? "Change photo" : "Add photo")
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
            }
            
            Form {
                Section("Quick Info") {
                    Text(petInfo)
                        .lineLimit(2)
                }
                
                Section("Breed") {
                    TextField("Breed", text: $breed)
                        .disabled(isFormDisabled)
                        .foregroundStyle(isFormDisabled ? .primary : Color.blue)
                }
                
                Section("Dates") {
                    DatePicker(
                        "Born on",
                        selection: $birthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(isFormDisabled ? .primary : Color.blue)
                    
                    DatePicker(
                        pet.adopted ? "Adopted on" : "On the family since",
                        selection: $onFamilySince,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(isFormDisabled ? .primary : Color.blue)
                }
                .disabled(isFormDisabled)
                
                Section("Weight (Kg.)") {
                    NavigationLink{
                        WeightList(pet: pet)
                    } label: {
                        Text("\(pet.reverseSortedWeights[0].value.formatted())")
                    }
                }
            }
        }
        .navigationTitle(pet.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isFormDisabled ? "Edit" : "Done") {
                    withAnimation {
                        isFormDisabled.toggle()
                    }
                    
//                    print(isFormDisabled)
                    
                    if isFormDisabled {
                        pet.breed = breed
                        pet.birthday = birthday
                        pet.onFamilySince = onFamilySince
                    }
                }
            }
            
//            ToolbarItem(placement: .status) {
//                Text(pet.age)
//                    .font(.caption)
//            }
        }
        .onAppear {
            breed = pet.breed
            birthday = pet.birthday
            onFamilySince = pet.onFamilySince
            petInfo = getQuickInfo(from: pet)
        }
        .task(id: selectedImage) {
            if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                pet.image = data
            }
        }
    }
    
    func getQuickInfo(from pet: Pet) -> String {
        "\(pet.name) is a \(pet.age) \(compliments.randomElement()!) \(pet.sex.rawValue) \(pet.type.rawValue)"
    }
}

#Preview {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
    }
}

