//
//  DewormingList.swift
//  Pets
//
//  Created by MZiO on 19/6/24.
//

import SwiftData
import SwiftUI

struct DewormingTreatmentList: View {
    @Query(sort: \DewormingTreatment.startingDate, order: .reverse) 
    var dewormingTreatments: [DewormingTreatment]
    
    @Environment(\.modelContext) private var modelContext
    
    static var now: Date { Date.now }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        ForEach(dewormingTreatments) { deworming in
                            NavigationLink{
                                // go to deworming details
                            } label: {
                                DewormingTreatmentListRow(
                                    dewormingTreatment: deworming
                                )
                            }
                        }
                        .onDelete(perform: deteleDewormings)
                    }
                }
            }
            .navigationTitle("Pets deworming")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem {
//                    EditButton()
                }
            }
        }
    }
    
    
    private func deteleDewormings(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(dewormingTreatments[$0]) }
    }
}


#Preview {
    DewormingTreatmentList()
        .modelContainer(SampleData.shared.modelContainer)
}
