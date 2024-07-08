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
                if pet.vaccines.isEmpty {
                    VaccineNoVaccines()
                } else {
                    List {
                        Section("Active Vaccines") {
                            ForEach(pet.reverseSortedVaccines) { vaccine in
                                if vaccine.activeDays > 0 {
                                    NavigationLink {
                                        VaccineDetails(pet: pet, vaccine: vaccine)
                                    } label: {
                                        VaccineListRow(vaccine: vaccine)
                                    }
                                }
                            }
                        }
                        
                        if pet.expiredVaccines > 0 {
                            Section("Expired Vaccines") {
                                ForEach(pet.reverseSortedVaccines) { vaccine in
                                    if vaccine.activeDays <= 0 {
                                        NavigationLink {
                                            VaccineDetails(pet: pet, vaccine: vaccine)
                                        } label: {
                                            VaccineListRow(vaccine: vaccine)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(pet.name)'s vaccines")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingVaccineDetail) {
                VaccineDetails(pet: pet, isNew: true)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showingVaccineDetail = true
                    } label: {
                        Label("Add vaccine", systemImage: "plus")
                    }
                    
                }
                
                ToolbarItem {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}


#Preview("Vaxxed pet") {
    VaccineList(pet: SampleData.shared.petWithExpiredVaccines)
}

#Preview("No vaccines yet") {
    VaccineList(pet: SampleData.shared.petWithoutSpecies)
}
