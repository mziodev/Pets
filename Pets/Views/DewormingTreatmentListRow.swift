//
//  DewormingListRow.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftUI

struct DewormingTreatmentListRow: View {
    let dewormingTreatment: DewormingTreatment
    
    var body: some View {
        HStack {
            Image(systemName: dewormingTreatment.type.systemImage)
                .font(.title)
                .foregroundStyle(
                    dewormingTreatment.isActive ? Color.accent : .secondary
                )
                .accessibilityLabel(
                    dewormingTreatment.type.localizedDescription
                )
            
            VStack(alignment: .leading) {
                Text(dewormingTreatment.name)
                    .font(.headline)
                
                Text(
                    dewormingTreatment.startingDate.formatted(
                        date: .abbreviated,
                        time: .omitted
                    )
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if dewormingTreatment.isActive {
                if dewormingTreatment.activeDays > 0 {
                    VStack(alignment: .center) {
                        Text("\(dewormingTreatment.activeDays)")
                            .font(.title3)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundStyle(
                                dewormingTreatment.activeDaysColor
                            )
                        
                        Text("More days")
                            .font(.caption2.smallCaps())
                            .bold()
                    }
                } else if dewormingTreatment.activeDays == 0 {
                    Text("Last day")
                        .font(.caption2.smallCaps())
                        .bold()
                        .foregroundStyle(.red)
                }
            } else {
                HStack {
                    Text("Expired")
                        .font(.subheadline.smallCaps())
                }
                .foregroundStyle(.secondary)
            }
        }
        .foregroundStyle(dewormingTreatment.isActive ? .primary : .secondary)
    }
}


#Preview("Active deworming") {
    List {
        DewormingTreatmentListRow(dewormingTreatment: DewormingTreatment.sampleData[0])
    }
}

#Preview("Expired deworming") {
    List {
        DewormingTreatmentListRow(dewormingTreatment: DewormingTreatment.sampleData[3])
    }
}
