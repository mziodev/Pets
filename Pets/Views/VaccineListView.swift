//
//  VaccineListView.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var showingVaccineDetailView: Bool = false
    
    private func showVaccineDetailsView() {
        showingVaccineDetailView = true
    }
    
    private func dismissView() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            List {
                if pet.unwrappedVaccines.active > 0 {
                    Section("Active Vaccines") {
                        ForEach(
                            pet.unwrappedVaccines.reverseSortedByActiveDays
                        ) { vaccine in
                            if vaccine.activeDays >= 0 {
                                NavigationLink {
                                    VaccineDetailsView(pet: pet, vaccine: vaccine)
                                } label: {
                                    VaccineListRowView(vaccine: vaccine)
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
                            if vaccine.activeDays < 0 {
                                NavigationLink {
                                    VaccineDetailsView(
                                        pet: pet,
                                        vaccine: vaccine
                                    )
                                } label: {
                                    VaccineListRowView(vaccine: vaccine)
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
                    NoVaccinesYetView()
                }
            }
            .sheet(isPresented: $showingVaccineDetailView) {
                VaccineDetailsView(pet: pet, isNew: true)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingVaccineDetailView = true
                    } label: {
                        Label("Add vaccine", systemImage: "plus")
                    }
                    
                }
            }
        }
    }
}

#Preview("Vaxxed pet") {
    VaccineListView(pet: SampleData.shared.petWithExpiredVaccines)
        .environmentObject(PetsStoreManager())
}

#Preview("No vaccines yet") {
    VaccineListView(pet: SampleData.shared.petWithoutSpecies)
        .environmentObject(PetsStoreManager())
}

struct NoVaccinesYetView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No vaccines yet", systemImage: "syringe")
                .foregroundStyle(.accent)
        } description: {
            Text("Tap on the plus button to add new vaccines.")
        }
    }
}
