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
                    if pet.vaccines.active > 0 {
                        Section("Active Vaccines") {
                            ForEach(
                                pet.vaccines.reverseSortedByActiveDays
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
                    
                    if pet.vaccines.expired > 0 {
                        Section("Expired Vaccines") {
                            ForEach(
                                pet.vaccines.reverseSortedByActiveDays
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
                if pet.vaccines.isEmpty {
                    VaccineListEmpty()
                }
            }
            .sheet(isPresented: $showingVaccineDetail) {
                VaccineDetail(pet: pet, isNew: true)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismissView)
                }
                
                ToolbarItem {
                    Button {
                        showingVaccineDetail = true
                    } label: {
                        Label("Add vaccine", systemImage: "plus")
                    }
                    
                }
                
                if pet.vaccines.active > 0 {
                    ToolbarItem {
                        Button("Done", action: dismissView)
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
}


#Preview("Vaxxed pet") {
    VaccineList(pet: SampleData.shared.petWithExpiredVaccines)
}

#Preview("No vaccines yet") {
    VaccineList(pet: SampleData.shared.petWithoutSpecies)
}
