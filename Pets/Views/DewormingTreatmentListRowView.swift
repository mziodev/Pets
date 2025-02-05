//
//  DewormingTreatmentListRowView.swift
//  Pets
//
//  Created by MZiO on 20/6/24.
//

import SwiftUI

struct DewormingTreatmentListRowView: View {
    
    let dewormingTreatment: DewormingTreatment
    
    var body: some View {
        HStack {
            Label(
                dewormingTreatment.type.localizedDescription,
                systemImage: dewormingTreatment.type.systemImage
            )
            .labelStyle(.iconOnly)
            .font(.title)
            .foregroundStyle(
                dewormingTreatment.isActive ? Color.accent : .secondary
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
                Text("Expired")
                    .font(.subheadline.smallCaps())
            }
        }
        .foregroundStyle(dewormingTreatment.isActive ? .primary : .secondary)
    }
}


#Preview {
    List(DewormingTreatment.sampleData) { deworming in
        DewormingTreatmentListRowView(dewormingTreatment: deworming)
    }
}
