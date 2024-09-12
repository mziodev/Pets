//
//  VaccineList.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineList: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var showingVaccineDetail: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if pet.unwrappedVaccines.active > 0 {
                        Section("Active Vaccines") {
                            ForEach(
                                pet.unwrappedVaccines.reverseSortedByActiveDays
                            ) { vaccine in
                                if vaccine.activeDays > 0 {
                                    NavigationLink {
                                        VaccineDetail(
                                            pet: pet,
                                            vaccine: vaccine
                                        )
                                    } label: {
                                        VaccineListRow(vaccine: vaccine)
                                    }
                                }
                            }
                        }
                    }
                    
                    if pet.unwrappedVaccines.expired > 0 {
                        Section("Expired Vaccines") {
                            ForEach(
                                pet.unwrappedVaccines.reverseSortedByActiveDays
                            ) { vaccine in
                                if vaccine.activeDays <= 0 {
                                    NavigationLink {
                                        VaccineDetail(
                                            pet: pet,
                                            vaccine: vaccine
                                        )
                                    } label: {
                                        VaccineListRow(vaccine: vaccine)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(pet.name)'s vaccines")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if pet.unwrappedVaccines.isEmpty {
                    VaccineListEmpty()
                }
            }
            .sheet(isPresented: $showingVaccineDetail) {
                VaccineDetail(pet: pet, isNew: true)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingVaccineDetail = true
                    } label: {
                        Label("Add vaccine", systemImage: "plus")
                    }
                    
                }
                
                if !pet.unwrappedVaccines.isEmpty {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Ok", action: dismissView)
                    }
                } else {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: dismissView)
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
}


#Preview("Vaxxed pet") {
    VaccineList(pet: SampleData.shared.petWithExpiredVaccines)
        .environmentObject(PetsStoreManager())
}

#Preview("No vaccines yet") {
    VaccineList(pet: SampleData.shared.petWithoutSpecies)
        .environmentObject(PetsStoreManager())
}
