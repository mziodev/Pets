//
//  DewormingHistoryListRow.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftUI

struct DewormingHistoryListRow: View {
    var treatmentName: String
    var treatmentDate: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(treatmentName)
                .font(.headline)
            
            Text(
                treatmentDate.formatted(
                    date: .abbreviated,
                    time: .omitted
                )
            )
            .font(.subheadline)
        }
    }
}

#Preview {
    DewormingHistoryListRow(treatmentName: "Seresto", treatmentDate: .now)
}
