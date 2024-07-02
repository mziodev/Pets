//
//  VaccineDetails.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineDetails: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var vaccine: Vaccine
    @State private var editingVaccine: Bool = false
    @State private var showingDeleteAlert: Bool = false
    
    @FocusState private var vaccineNameTextFieldFocused: Bool
    
    let isNew: Bool
    
    private var isNameVerified: Bool {
        FormVerification.checkMinimumLength(vaccine.name)
    }
    private var isFormVerified: Bool { isNameVerified }
    
    
    init(
        pet: Pet,
        vaccine: Vaccine = Vaccine(),
        isNew: Bool = false
    ) {
        self.pet = pet
        self.vaccine = vaccine
        self.isNew = isNew
    }
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Product Info") {
                        TextField("Name", text: $vaccine.name)
                            .focused($vaccineNameTextFieldFocused)
                            .scrollDismissesKeyboard(.immediately)
                        
                        Picker("Type", selection: $vaccine.type) {
                            ForEach(VaccineType.allCases) { vaccine in
                                if vaccine.species.isEmpty {
                                    Text(vaccine.rawValue)
                                }
                            }
                            
                            Section {
                                ForEach(VaccineType.allCases) { vaccine in
                                    if vaccine.species == "dogs" {
                                        Text(vaccine.rawValue)
                                    }
                                }
                            } header: {
                                Text("For dogs")
                                    .font(.headline.smallCaps())
                                    .foregroundStyle(.petsAccentBlue)
                            }
                            
                            Section {
                                ForEach(VaccineType.allCases) { vaccine in
                                    if vaccine.species == "cats" {
                                        Text(vaccine.rawValue)
                                    }
                                }
                            } header: {
                                Text("For cats")
                                    .font(.headline.smallCaps())
                                    .foregroundStyle(.petsAccentBlue)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .foregroundStyle(.primary)
                    }
                    
                    if vaccine.type != .unknown {
                        Section {
                            Text(vaccine.type.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSpacing(0)
                    }
                    
                    Section("Dates") {
                        DatePicker(
                            "Date",
                            selection: $vaccine.date,
                            displayedComponents: .date
                        )
                        
                        DatePicker(
                            "Expiration date",
                            selection: $vaccine.expirationDate,
                            displayedComponents: .date
                        )
                    }
                    
                    if vaccine.activeDays > 0 {
                        Section {
                            Text("Still **\(vaccine.activeDays)** more days until next vaccine.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSpacing(0)
                    } else if !isNew {
                        Section {
                            HStack {
                                Spacer()
                                
                                Text("Expired Vaccine")
                                    .font(.headline.lowercaseSmallCaps())
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listSectionSpacing(0)
                    }
                }
                .disabled(!editingVaccine)
                
                if !isNew {
                    Button("Delete vaccine", role: .destructive, action: deleteVaccine)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                }
            }
            .navigationTitle(isNew ? "Add Vaccine" : "Vaccine Details")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if isNew { editingVaccine = true }
                vaccineNameTextFieldFocused = true
            }
            .alert("Warning!", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel, action: { })
                Button( "Ok", role: .destructive, action: deleteVaccine)
            } message: {
                Text("Vaccine data will be deleted, are you sure?")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    if editingVaccine {
                        Button("Save", action: appendVaccine)
                            .disabled(!isFormVerified)
                    } else {
                        Button("Edit", action: editVaccine)
                    }
                }
                
                if isNew {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
            }
        }
    }
    
    
    private func editVaccine() {
        withAnimation {
            editingVaccine = true
        }
    }
    
    private func appendVaccine() {
        pet.vaccines.append(vaccine)
        dismiss()
    }
    
    private func deleteVaccine() {
        if let vaccineIndex = pet.vaccines.firstIndex(where: {
            $0.id == vaccine.id
        }) {
            pet.vaccines.remove(at: vaccineIndex)
            dismiss()
        }
    }
}


#Preview("New vaccine") {
    VaccineDetails(pet: SampleData.shared.petWithoutSpecies, isNew: true)
}

#Preview("Existing vaccine") {
    VaccineDetails(pet: SampleData.shared.petWithChipID, vaccine: SampleData.shared.petWithChipID.vaccines[0])
}

#Preview("Expired vaccine") {
    VaccineDetails(pet: SampleData.shared.petWithChipID, vaccine: SampleData.shared.petWithExpiredVaccines.vaccines[1])
}
