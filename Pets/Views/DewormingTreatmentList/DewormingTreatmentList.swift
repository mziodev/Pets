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
//    @Environment(\.modelContext) var modelContext
    
    @ObservedObject var pet: Pet
    
    @State private var showingDewormingTreatmentDetail: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Active treatments") {
                        ForEach(pet.reverseSortedDewormingTreatments) { deworming in
                            if (deworming.activeDays > 0) {
                                NavigationLink{
                                    // go to deworming details
                                } label: {
                                    DewormingTreatmentListRow(
                                        dewormingTreatment: deworming
                                    )
                                }
                            }
                        }
                    }
                    
                    Section("Expired treatments") {
                        ForEach(pet.reverseSortedDewormingTreatments) { deworming in
                            if (deworming.activeDays <= 0) {
                                NavigationLink{
                                    // go to deworming details
                                } label: {
                                    DewormingTreatmentListRow(
                                        dewormingTreatment: deworming
                                    )
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(pet.name) deworming")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .sheet(isPresented: $showingDewormingTreatmentDetail) {
                DewormingTreatmentDetail(
                    dewormingTreatment: DewormingTreatment(pet: pet),
                    isNew: true
                )
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingDewormingTreatmentDetail = true
                    } label: {
                        Label("Add deworming treatment", systemImage: "plus")
                    }
                }
                
                ToolbarItem {
                    Button("Done") { dismiss() }
                }
                
                ToolbarItem(placement: .status) {
                    Text("\(pet.activeDewormingTreatments) active treatments")
                        .font(.caption)
                }
            }
        }
    }
}


#Preview {
    DewormingTreatmentList(pet: SampleData.shared.petWithChipID)
        .modelContainer(SampleData.shared.modelContainer)
}
