//
//  DewormingListRow.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftUI

struct DewormingActiveListRow: View {
    var treatmentName: String
    var treatmentDate: Date
    var remainingTreatmentDays: Int
    
    let range = 7...15
    
    var remainingTreatmentDaysColor: Color {
        if remainingTreatmentDays < 7 {
            return .red
        } else if range.contains(remainingTreatmentDays) {
            return .yellow
        } else {
            return .green
        }
    }
    
    var body: some View {
        HStack {
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
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("\(remainingTreatmentDays)")
                    .font(.title2)
                    .fontDesign(.serif)
                    .bold()
                    .foregroundStyle(remainingTreatmentDaysColor)
                
                Text("more days")
                    .font(.caption)
            }
        }
    }
}


#Preview {
    List {
        DewormingActiveListRow(treatmentName: "Nexgard Spectra", treatmentDate: .now, remainingTreatmentDays: 45)
    }
}
