//
//  DewormingHistoryList.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftData
import SwiftUI

struct DewormingRecord: View {
    @Query(filter: #Predicate<DewormingTreatment> { deworming in
        deworming.endingDate <= now
    }, sort: \DewormingTreatment.startingDate, order: .reverse)
    var dewormingHistory: [DewormingTreatment]
    
    static var now: Date { Date.now }
    
    var body: some View {
        NavigationStack {
            Image(systemName: "archivebox.fill")
                .font(.system(size: 80))
                .foregroundStyle(.tint)
                .padding(.top)
            
            List {
                ForEach(dewormingHistory) { deworming in
                    NavigationLink {
                        // go to deworming details
                    } label: {
                        DewormingHistoryListRow(
                            treatmentName: deworming.name,
                            treatmentDate: deworming.startingDate
                        )
                    }
                }
            }
            .navigationTitle("Pets deworming record")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DewormingRecord()
        .modelContainer(SampleData.shared.modelContainer)
}

