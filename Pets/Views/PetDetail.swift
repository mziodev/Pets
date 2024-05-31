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
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var selectedImage: PhotosPickerItem?
    @State var petInfo = ""
    @State var editingPetDetails = false
    @State var showingAddWeightSheet = false
    
    let isNew: Bool
    
    @FocusState var breedTextFieldFocused: Bool
    
    private let petCompliments = [
        "handsome",
        "beautiful",
        "lovely",
        "nice",
        "good-looking",
        "cute",
        "pretty"
    ]
    
    
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
                if let imageData = pet.image,
                    let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())

                } else {
                    PlaceholderPetImage(petSpecies: pet.species)
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
                if !isNew {
                    Section("Quick Info") {
                        Text(petInfo)
                            .lineLimit(2)
                    }
                }
                
                Section("Breed") {
                    TextField("Breed", text: $pet.breed)
                        .disabled(!editingPetDetails)
                        .foregroundStyle(
                            editingPetDetails ? Color.accentColor : .primary
                        )
                        .focused($breedTextFieldFocused)
                }
                
                if !pet.chipID.isEmpty || editingPetDetails {
                    Section("Chip") {
                        Picker("Chip ID type", selection: $pet.chipID) {
                            ForEach(ChipIDType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .disabled(!pet.chipID.isEmpty)
                        .pickerStyle(.navigationLink)
                        .foregroundStyle(
                            editingPetDetails ? Color.accentColor : .primary
                        )
                        
                        NavigationLink {
                            ChipBarcode(chipID: pet.chipID)
                        } label: {
                            TextField("Chip ID", text: $pet.chipID)
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
                        selection: $pet.birthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(
                        editingPetDetails ? Color.accentColor : .primary
                    )
                    
                    DatePicker(
                        pet.isAdopted ? "Adopted on" : "On the family since",
                        selection: $pet.onFamilySince,
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
        
        
        // MARK: - onApear
        .onAppear {
            if isNew {
                breedTextFieldFocused.toggle()
            } else {
                petInfo = getQuickInfo(from: pet)
            }
        }
        
        
        // MARK: - add weight sheet
        .sheet(isPresented: $showingAddWeightSheet) {
            AddWeight(pet: pet)
        }
        
        
        // MARK: - tasks
        .task(id: selectedImage) {
            if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                pet.image = data
            }
        }
        
        
        // MARK: - toolbar
        .toolbar {
            ToolbarItem {
//                Button {
//                    showingAddWeightSheet.toggle()
//                } label: {
//                    Image(systemName: "plus")
//                }
//                .accessibilityLabel("Add weight")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(editingPetDetails ? "Done" : "Edit") {
                    withAnimation {
                        editingPetDetails.toggle()
                    }
                    
                    breedTextFieldFocused.toggle()
                }
            }
        }
    }
    
    
    // MARK: - functions
    private func getQuickInfo(from pet: Pet) -> String {
        "\(pet.name) is a \(pet.age) \(petCompliments.randomElement()!) \(pet.sex.rawValue) \(pet.species.rawValue)"
    }
}


// MARK: - previews
#Preview("Light mode") {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
//            .environment(\.locale, Locale(identifier: "en_US"))
    }
}

#Preview("Dark mode") {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
            .preferredColorScheme(.dark)
//            .environment(\.locale, Locale(identifier: "es_ES"))
    }
}

