//
//  DewormingList.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import SwiftData
import SwiftUI

struct DewormingActiveList: View {
    @Query(filter: #Predicate<Deworming> { deworming in
        deworming.expirationDate > now
    } , sort: \Deworming.expirationDate) var activeDewormings: [Deworming]
    
    @Environment(\.modelContext) private var modelContext
    
    static var now: Date { Date.now }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Active deworming") {
                        ForEach(activeDewormings) { deworming in
                            NavigationLink{
                                // go to deworming details
                            } label: {
                                DewormingActiveListRow(
                                    treatmentName: deworming.treatmentName,
                                    treatmentDate: deworming.date,
                                    remainingTreatmentDays: deworming.remainingTreatmentDays
                                )
                            }
                        }
                        .onDelete(perform: deteleDewormings)
                    }
                }
            }
            .navigationTitle("Pets deworming list")
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
            }
        }
    }
    
    private func deteleDewormings(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(activeDewormings[$0]) }
    }
}

#Preview {
    DewormingActiveList()
        .modelContainer(SampleData.shared.modelContainer)
}
