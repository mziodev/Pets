//
//  DewormingList.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import SwiftData
import SwiftUI

struct DewormingTreatmentList: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var showingDewormingTreatmentDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if pet.dewormingTreatments.active > 0 {
                        Section("Active treatments") {
                            ForEach(
                                pet.dewormingTreatments.reverseSortedByActiveDays
                            ) { treatment in
                                if (treatment.activeDays > 0) {
                                    NavigationLink{
                                        DewormingTreatmentDetail(
                                            pet: pet,
                                            dewormingTreatment: treatment
                                        )
                                    } label: {
                                        DewormingTreatmentListRow(
                                            dewormingTreatment: treatment
                                        )
                                    }
                                }
                            }
                        }
                    }
                    
                    if pet.dewormingTreatments.expired > 0 {
                        Section("Expired treatments") {
                            ForEach(
                                pet.dewormingTreatments.reverseSortedByActiveDays
                            ) { treatment in
                                if (treatment.activeDays <= 0) {
                                    NavigationLink{
                                        DewormingTreatmentDetail(
                                            pet: pet,
                                            dewormingTreatment: treatment
                                        )
                                    } label: {
                                        DewormingTreatmentListRow(
                                            dewormingTreatment: treatment
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(pet.name)'s dewormings")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if pet.dewormingTreatments.isEmpty {
                    DewormingTreatmentListEmpty()
                }
            }
            .sheet(isPresented: $showingDewormingTreatmentDetail) {
                DewormingTreatmentDetail(
                    pet: pet,
                    isNew: true
                )
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingDewormingTreatmentDetail = true
                    } label: {
                        Label(
                            "Add deworming treatment",
                            systemImage: "plus"
                        )
                    }
                }
                
                if !pet.dewormingTreatments.isEmpty {
                    ToolbarItem {
                        Button("Done", action: dismissView)
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text(
                            "\(pet.dewormingTreatments.active) active treatments"
                        )
                        .font(.caption)
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
}

#Preview("Empty Treatment List") {
    DewormingTreatmentList(pet: SampleData.shared.petWithExpiredVaccines)
}

#Preview("Existing Treatment List") {
    DewormingTreatmentList(pet: SampleData.shared.petWithChipID)
}
