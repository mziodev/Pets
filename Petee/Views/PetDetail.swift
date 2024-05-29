//
//  PetDetail.swift
//  Petee
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

let formatStyle = Measurement<UnitMass>.FormatStyle(
    width: .abbreviated,
    numberFormatStyle: .number
)

struct PetDetail: View {
    @Bindable var pet: Pet
    
    @FocusState var isBreedTextFieldFocused: Bool
    
    
    // MARK: - state pet properties
    @State var breed = ""
    @State var chipIDType: ChipIDType = .fifteenDigits
    @State var chipID = ""
    @State var birthday = Date.now
    @State var onFamilySince = Date.now
    @State var selectedImage: PhotosPickerItem?
    
    @State var petInfo = ""
    @State var editingPetDetails = false
    @State var showingAddWeightSheet = false
    
    private let petCompliments = [
        "handsome",
        "beautiful",
        "lovely",
        "nice",
        "good-looking",
        "cute",
        "pretty"
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
                    GenericPetImage(petSpecies: pet.species)
                }
                
                if editingPetDetails {
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
            
            
            // MARK: - form
            Form {
                Section("Quick Info") {
                    Text(petInfo)
                        .lineLimit(2)
                }
                
                Section("Breed") {
                    TextField("Breed", text: $breed)
                        .disabled(!editingPetDetails)
                        .foregroundStyle(
                            editingPetDetails ? Color.accentColor : .primary
                        )
                        .focused($isBreedTextFieldFocused)
                }
                
                if !chipID.isEmpty || editingPetDetails {
                    Section("Chip") {
                        Picker("Chip ID type", selection: $chipIDType) {
                            ForEach(ChipIDType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .disabled(!chipID.isEmpty)
                        .pickerStyle(.navigationLink)
                        .foregroundStyle(
                            editingPetDetails ? Color.accentColor : .primary
                        )
                        
                        NavigationLink {
                            ChipBarcode(chipID: chipID)
                        } label: {
                            TextField("Chip ID", text: $chipID)
                                .disabled(!editingPetDetails)
                                .foregroundStyle(
                                    editingPetDetails ? Color.accentColor : .primary
                                )
                        }
                    }
                }
                
                
                Section("Dates") {
                    DatePicker(
                        "Born on",
                        selection: $birthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(
                        editingPetDetails ? Color.accentColor : .primary
                    )
                    
                    DatePicker(
                        pet.isAdopted ? "Adopted on" : "On the family since",
                        selection: $onFamilySince,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(
                        editingPetDetails ? Color.accentColor : .primary
                    )
                }
                .disabled(!editingPetDetails)
                
                if !editingPetDetails && !pet.weights.isEmpty {
                    Section("Weight") {
                        NavigationLink{
                            WeightList(pet: pet)
                        } label: {
                            HStack {
                                Text("Current weight")
                                
                                Spacer()
                                
                                Text(
                                    Weight.getMeasuredValue(
                                        from: pet.reverseSortedWeights.first!.value
                                    ),
                                    format: formatStyle
                                )
                            }
                        }
                    }
                }
            }
            // form background color change
            /*
            .scrollContentBackground(.hidden)
            .background(Color.ptLightBlue)
             */
        }
        .navigationTitle(pet.name)
        
        
        // MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
//                AddMenu()
                
                Button {
                    showingAddWeightSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add weight")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(editingPetDetails ? "Done" : "Edit") {
                    withAnimation {
                        editingPetDetails.toggle()
                    }
                    
                    isBreedTextFieldFocused.toggle()
                    
                    if !editingPetDetails {
                        pet.breed = breed
                        pet.chipID = chipID
                        pet.birthday = birthday
                        pet.onFamilySince = onFamilySince
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddWeightSheet) {
            AddWeight(pet: pet)
        }
        .onAppear {
            breed = pet.breed
            chipID = pet.chipID
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
    
    
    // MARK: - functions
    private func getQuickInfo(from pet: Pet) -> String {
        "\(pet.name) is a \(pet.age) \(petCompliments.randomElement()!) \(pet.sex.rawValue) \(pet.species.rawValue)"
    }
}


// MARK: - previews
#Preview("Light mode, UK locale") {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
            .environment(\.locale, Locale(identifier: "en_UK"))
    }
}

#Preview("Light mode, US locale") {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
            .environment(\.locale, Locale(identifier: "en_US"))
    }
}

#Preview("Dark mode, ES locale") {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
            .preferredColorScheme(.dark)
            .environment(\.locale, Locale(identifier: "es_ES"))
    }
}

