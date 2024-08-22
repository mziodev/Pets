//
//  VaccineDetail.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI


struct VaccineDetail: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var vaccine: Vaccine
    
    @State private var editingVaccine: Bool = false
    @State private var showingDeleteAlert: Bool = false
    
    @FocusState private var vaccineNameTextFieldFocused: Bool
    
    let isNew: Bool
    
    private var isVaccineExpired: Bool {
        vaccine.activeDays <= 0 && !isNew
    }
    
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
                    Section {
                        TextField("Name", text: $vaccine.name)
                            .focused($vaccineNameTextFieldFocused)
                        
                        Picker("Type", selection: $vaccine.type) {
                            ForEach(
                                VaccineType.allCases,
                                id: \.self
                            ) { vaccine in
                                if vaccine.species == "unknown" {
                                    Text(vaccine.localizedDescription)
                                        .font(.callout)
                                }
                            }
                            
                            Section {
                                ForEach(
                                    VaccineType.allCases,
                                    id: \.self
                                ) { vaccine in
                                    if vaccine.species == "dogs" {
                                        Text(vaccine.rawValue)
                                            .font(.callout)
                                    }
                                }
                            } header: {
                                Text("For dogs")
                                    .font(.headline.smallCaps())
                                    .foregroundStyle(.petsAccentBlue)
                            }
                            
                            Section {
                                ForEach(
                                    VaccineType.allCases,
                                    id: \.self
                                ) { vaccine in
                                    if vaccine.species == "cats" {
                                        Text(vaccine.rawValue)
                                            .font(.callout)
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
                    } header: {
                        Text("Product Info")
                    } footer: {
                        if vaccine.type != .unknown {
                            Text(isVaccineExpired ? "\(pet.name) was protected against \(vaccine.type.localizedDescription)." : "\(pet.name) will be protected against \(vaccine.type.localizedDescription).")
                        }
                    }
                    
                    
                    Section {
                        DatePicker(
                            isVaccineExpired ? "Started" : "Starts",
                            selection: $vaccine.starts,
                            in: pet.birthday ... .now,
                            displayedComponents: .date
                        )
                        
                        DatePicker(
                            isVaccineExpired ? "Ended" : "Ends",
                            selection: $vaccine.ends,
                            in: pet.birthday ... .distantFuture,
                            displayedComponents: .date
                        )
                    } header: {
                        Text("Dates")
                    } footer: {
                        if isVaccineExpired {
                            HStack {
                                Spacer()
                                
                                Text("Expired Vaccine")
                                    .font(.headline.smallCaps())
                                
                                Spacer()
                            }
                        } else {
                            Text("\(pet.name) still will be protected \(vaccine.activeDays) more days until next vaccine.")
                        }
                    }
                }
                .disabled(!editingVaccine)
                .scrollDismissesKeyboard(.immediately)
            }
            .navigationTitle(isNew ? "Add Vaccine" : "Vaccine Details")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if !isNew {
                    VStack {
                        Spacer()
                        
                        Button("Delete vaccine", role: .destructive) {
                            showingDeleteAlert = true
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                }
            }
            .onAppear {
                if isNew { editingVaccine = true }
                vaccineNameTextFieldFocused = true
            }
            .alert("Warning!", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel, action: { })
                Button( "Ok", role: .destructive, action: deleteVaccine)
            } message: {
                Text("This vaccine data will be deleted, are you sure?")
            }
            .toolbar {
                if editingVaccine {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: editVaccine)
                    }
                }
                
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
                        Button("Cancel", action: dismissView)
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
    
    private func editVaccine() {
        withAnimation {
            editingVaccine.toggle()
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
    VaccineDetail(
        pet: SampleData.shared.petWithoutSpecies,
        isNew: true
    )
}

#Preview("Existing vaccine") {
    VaccineDetail(
        pet: SampleData.shared.petWithChipID,
        vaccine: SampleData.shared.petWithChipID.vaccines[0]
    )
}

#Preview("Expired vaccine") {
    VaccineDetail(
        pet: SampleData.shared.petWithChipID,
        vaccine: SampleData.shared.petWithExpiredVaccines.vaccines[1]
    )
}
