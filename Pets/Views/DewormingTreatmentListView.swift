 //
//  DewormingTreatmentListView.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import SwiftData
import SwiftUI

struct DewormingTreatmentListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var showingDewormingTreatmentDetails: Bool = false
    
    private func showDewormingTreatmentDetailsView() {
        showingDewormingTreatmentDetails = true
    }
    
    private func dismissView() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            List {
                if pet.unwrappedDewormingTreatments.active > 0 {
                    Section("Active treatments") {
                        ForEach(
                            pet.unwrappedDewormingTreatments.reverseSortedByActiveDays
                        ) { treatment in
                            if (treatment.activeDays >= 0) {
                                NavigationLink{
                                    DewormingTreatmentDetailsView(
                                        pet: pet,
                                        dewormingTreatment: treatment
                                    )
                                } label: {
                                    DewormingTreatmentListRowView(
                                        dewormingTreatment: treatment
                                    )
                                }
                            }
                        }
                    }
                }
                
                if pet.unwrappedDewormingTreatments.expired > 0 {
                    Section("Expired treatments") {
                        ForEach(
                            pet.unwrappedDewormingTreatments.reverseSortedByActiveDays
                        ) { treatment in
                            if (treatment.activeDays < 0) {
                                NavigationLink{
                                    DewormingTreatmentDetailsView(
                                        pet: pet,
                                        dewormingTreatment: treatment
                                    )
                                } label: {
                                    DewormingTreatmentListRowView(
                                        dewormingTreatment: treatment
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(pet.name)'s dewormings")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if pet.unwrappedDewormingTreatments.isEmpty {
                    NoDewormingTreatmentsYet()
                }
            }
            .sheet(isPresented: $showingDewormingTreatmentDetails) {
                DewormingTreatmentDetailsView(
                    pet: pet,
                    isNew: true
                )
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: showDewormingTreatmentDetailsView) {
                        Label(
                            "Add deworming treatment",
                            systemImage: "plus.circle.fill"
                        )
                        .labelStyle(.titleAndIcon)
                    }
                }
            }
        }
    }
}

#Preview("Empty Treatment List") {
    DewormingTreatmentListView(pet: SampleData.shared.petWithExpiredVaccines)
        .environmentObject(PetsStoreManager())
}

#Preview("Existing Treatment List") {
    DewormingTreatmentListView(pet: SampleData.shared.petWithChipID)
        .environmentObject(PetsStoreManager())
}

struct NoDewormingTreatmentsYet: View {
    var body: some View {
        ContentUnavailableView {
            Label("No deworming treatments yet", systemImage: "ant")
                .foregroundStyle(.accent)
        } description: {
            Text("Tap the plus button below to add a new deworming treatment.")
        }
    }
}
