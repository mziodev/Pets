//
//  VaccineDetail.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI


struct VaccineDetail: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    @Bindable var pet: Pet
    
    @State var vaccine: Vaccine
    
    @State private var editingVaccine: Bool = false
    @State private var showingNotificationTime = false
    @State private var showingDeleteAlert: Bool = false
    
    @FocusState private var vaccineNameTextFieldFocused: Bool
    
    let isNew: Bool
    
    private var isVaccineExpired: Bool {
        vaccine.activeDays <= 0 && !isNew
    }
    
    private var isNameVerified: Bool {
        vaccine.name.hasMinimumLength()
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
                .disabled(!editingVaccine)
                
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
                        in: vaccine.starts ... .distantFuture,
                        displayedComponents: .date
                    )
                    
                    if petsStoreManager.isPremiumUnlocked {
                        Picker(
                            "Notification",
                            selection: $vaccine.notification) {
                                ForEach(NotificationPeriod.allCases, id: \.self) { period in
                                    Text(period.localizedDescription)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: vaccine.notification) { oldValue, newValue in
                                withAnimation {
                                    showingNotificationTime = vaccine.notification != .none
                                }
                                
                                Notification.requestAuthorization()
                            }
                        
                        if showingNotificationTime {
                            DatePicker(
                                "Notification Time",
                                selection: $vaccine.notificationTime,
                                displayedComponents: .hourAndMinute
                            )
                        }
                    }
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
                    } else if !isNew {
                        Text("\(pet.name) still will be protected \(vaccine.activeDays) more days until next vaccine.")
                    }
                }
                .disabled(!editingVaccine)
                
                if petsStoreManager.isPremiumUnlocked {
                    Section("Notes") {
                        TextField(
                            "...",
                            text: $vaccine.notes,
                            axis: .vertical
                        )
                    }
                    .disabled(!editingVaccine)
                }
                
                if !petsStoreManager.isPremiumUnlocked {
                    Section {
                        HStack {
                            VStack {
                                Text("Unlock Notes, Notifications and some other features with Pets Premium.")
                                    .font(.caption)
                                
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        
                                    } label: {
                                        Label("go Premium!", systemImage: "crown")
                                            .bold()
                                    }
                                    .frame(width: 200, height: 44)
                                    .background(Color.petsAccentRed)
                                    .foregroundStyle(.white)
                                    .clipShape(.rect(cornerRadius: 30))
                                    .padding(.top)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                if !isNew && editingVaccine {
                    RowDeleteButton(
                        title: String(localized: "Delete Vaccine"),
                        showingAlert: $showingDeleteAlert
                    )
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
                Text("This vaccine data will be deleted, are you sure?")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    if editingVaccine {
                        Button("Save", action: appendVaccine)
                            .disabled(!isFormVerified)
                    } else {
                        Button("Edit", action: toggleEditingVaccine)
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
    
    private func toggleEditingVaccine() {
        withAnimation {
            editingVaccine.toggle()
            vaccineNameTextFieldFocused.toggle()
        }
    }
    
    private func appendVaccine() {
        pet.vaccines?.append(vaccine)
        dismiss()
    }
    
    private func deleteVaccine() {
        if let vaccineIndex = pet.unwrappedVaccines.firstIndex(where: {
            $0.id == vaccine.id
        }) {
            pet.vaccines?.remove(at: vaccineIndex)
            dismiss()
        }
    }
}

#Preview("New vaccine") {
    VaccineDetail(
        pet: SampleData.shared.petWithoutSpecies,
        isNew: true
    )
    .environmentObject(PetsStoreManager())
}

#Preview("Existing vaccine") {
    VaccineDetail(
        pet: SampleData.shared.petWithChipID,
        vaccine: SampleData.shared.petWithChipID.unwrappedVaccines[0]
    )
    .environmentObject(PetsStoreManager())
}

#Preview("Expired vaccine") {
    VaccineDetail(
        pet: SampleData.shared.petWithChipID,
        vaccine: SampleData.shared.petWithExpiredVaccines.unwrappedVaccines[1]
    )
    .environmentObject(PetsStoreManager())
}
