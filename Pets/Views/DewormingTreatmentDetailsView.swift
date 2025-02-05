//
//  DewormingTreatmentDetailsView.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftUI

struct DewormingTreatmentDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    @Bindable var pet: Pet
    
    @State var dewormingTreatment: DewormingTreatment
    
    @State private var treatmentQuantity: Double?
    @State private var editingTreatment = false
    @State private var showingPetsStore = false
    @State private var showingNotificationTime = false
    @State private var showingDeleteAlert = false
    
    @FocusState private var treatmentNameTextFieldFocused: Bool
    
    let isNew: Bool
    
    private let petsStoreAdText = String(
        localized: "Unlock Deworming Treatment Notes, Notifications and some other features with Pets Premium."
    )
    
    private var isNameVerified: Bool {
        dewormingTreatment.name.hasMinimumLength()
    }
    private var isQuantityVerified: Bool {
        dewormingTreatment.quantity > 0
    }
    private var isFormVerified: Bool {
        isNameVerified && isQuantityVerified
    }
    
    private func dismissView() {
        dismiss()
    }
    
    private func toggleEditingTreatment() {
        withAnimation {
            editingTreatment.toggle()
            treatmentNameTextFieldFocused.toggle()
        }
    }
    
    private func scheduleNotification() {
        let title = String(localized: "Deworming Treatment Warning")
        let body = String(localized: "\(pet.name) is running out of \(dewormingTreatment.name) coverage.")
        
        if dewormingTreatment.notification != .none {
            Notification.schedule(
                identifier: dewormingTreatment.notificationID,
                title: title,
                body: body,
                targetDate: dewormingTreatment.endingDate,
                daysBefore: dewormingTreatment.notification.value,
                notificationTime: dewormingTreatment.notificationTime
            )
        } else {
            Notification.removePendingNotifications(
                for: dewormingTreatment.notificationID
            )
        }
    }
    
    private func appendDewormingTreatment() {
        pet.dewormingTreatments?.append(dewormingTreatment)
        
        scheduleNotification()
        
        dismiss()
    }
    
    private func deleteDewormingTreatment() {
        if let dewormingTreatmentIndex = pet.unwrappedDewormingTreatments.firstIndex(
            where: { $0.id == dewormingTreatment.id
            }) {
            pet.dewormingTreatments?.remove(at: dewormingTreatmentIndex)
            
            dismiss()
        }
    }
    
    private func copyDewormingTreatmentQuantity() {
        if dewormingTreatment.quantity > 0 {
            treatmentQuantity = dewormingTreatment.quantity
        }
    }
    
    init(
        pet: Pet,
        dewormingTreatment: DewormingTreatment = DewormingTreatment(),
        isNew: Bool = false
    ) {
        self.pet = pet
        self.dewormingTreatment = dewormingTreatment
        self.isNew = isNew
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Label(
                                dewormingTreatment.type.localizedDescription,
                                systemImage: dewormingTreatment.type.systemImage
                            )
                            .labelStyle(.iconOnly)
                            .font(.system(size: 70))
                            .foregroundStyle(.accent)
                            
                            Text("\(pet.name)'s deworming treatment")
                                .font(.title3)
                                .padding(.top)
                        }
                        .animation(
                            .default,
                            value: dewormingTreatment.type
                        )
                        
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                Section("Info") {
                    TextField(
                        "Treatment name",
                        text: $dewormingTreatment.name
                    )
                    .focused($treatmentNameTextFieldFocused)
                    .overlay(alignment: .trailing) {
                        if isNameVerified {
                            CheckMarkLabel()
                        }
                    }
                    
                    Picker(
                        "Treatment type",
                        selection: $dewormingTreatment.type
                    ) {
                        ForEach(
                            TreatmentType.allCases,
                            id: \.self
                        ) { type in
                            Text(type.localizedDescription)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker(selection: $dewormingTreatment.units) {
                        ForEach(
                            TreatmentUnit.allCases,
                            id:\.self
                        ) { units in
                            Text(units.localizedDescription)
                        }
                    } label: {
                        HStack {
                            Text("Quantity")
                            
                            TextField(
                                "Quantity",
                                value: $treatmentQuantity,
                                format: .number
                            )
                            .multilineTextAlignment(.trailing)
                            .onChange(
                                of: treatmentQuantity ?? 0
                            ) { oldValue, newValue in
                                dewormingTreatment.quantity = newValue
                            }
                            .keyboardType(.decimalPad)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.trailing, 30)
                    .overlay(alignment: .trailing) {
                        if isQuantityVerified {
                            CheckMarkLabel()
                        }
                    }
                }
                .disabled(!editingTreatment)
                
                Section("Dates") {
                    DatePicker(
                        "Starts",
                        selection: $dewormingTreatment.startingDate,
                        in: pet.birthday ... .now,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        "Ends",
                        selection: $dewormingTreatment.endingDate,
                        in: dewormingTreatment.startingDate ... .distantFuture,
                        displayedComponents: .date
                    )
                    
                    if petsStoreManager.isPremiumUnlocked {
                        Picker(
                            "Notification",
                            selection: $dewormingTreatment.notification) {
                                ForEach(NotificationPeriod.allCases, id: \.self) { period in
                                    Text(period.localizedDescription)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: dewormingTreatment.notification) { oldValue, newValue in
                                withAnimation {
                                    showingNotificationTime = dewormingTreatment.notification != .none
                                }
                                
                                Notification.requestAuthorization()
                            }
                        
                        if showingNotificationTime {
                            DatePicker(
                                "Notification Time",
                                selection: $dewormingTreatment.notificationTime,
                                displayedComponents: .hourAndMinute
                            )
                        }
                    }
                }
                .disabled(!editingTreatment)
                
                if petsStoreManager.isPremiumUnlocked {
                    Section("Notes") {
                        TextField(
                            "...",
                            text: $dewormingTreatment.notes,
                            axis: .vertical
                        )
                    }
                    .disabled(!editingTreatment)
                }
                
                if !petsStoreManager.isPremiumUnlocked && editingTreatment {
                    GoPremiumAdView(
                        showingPetsStore: $showingPetsStore,
                        adText: petsStoreAdText
                    )
                }
                
                if !isNew && editingTreatment {
                    RowDeleteButton(
                        title: String(localized: "Delete Treatment"),
                        showingAlert: $showingDeleteAlert
                    )
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(
                isNew ? "Add Treatment" : "Treatment Details"
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                copyDewormingTreatmentQuantity()
                
                if isNew { editingTreatment = true }
                if dewormingTreatment.notification != .none {
                    showingNotificationTime = true
                } else {
                    dewormingTreatment.notificationTime = .now
                }
                
                treatmentNameTextFieldFocused = true
            }
            .sheet(isPresented: $showingPetsStore) { PetsStoreView() }
            .alert("Warning!", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel, action: { })
                Button(
                    "Ok",
                    role: .destructive,
                    action: deleteDewormingTreatment
                )
            } message: {
                Text("Deworming treatment will be deleted, are you sure?")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    if editingTreatment {
                        Button("Save", action: appendDewormingTreatment)
                            .disabled(!isFormVerified)
                    } else {
                        Button("Edit", action: toggleEditingTreatment)
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
}


#Preview("New deworming") {
    DewormingTreatmentDetailsView(
        pet: SampleData.shared.petWithChipID,
        isNew: true
    )
    .environmentObject(PetsStoreManager())
}

#Preview("Existing deworming") {
    DewormingTreatmentDetailsView(
        pet: SampleData.shared.petWithChipID,
        dewormingTreatment: SampleData.shared.petWithChipID.unwrappedDewormingTreatments[0]
    )
    .environmentObject(PetsStoreManager())
}
