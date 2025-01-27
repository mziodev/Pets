//
//  VaccineListRow.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineListRow: View {
    let vaccine: Vaccine
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(vaccine.name)
                    .font(.headline)
                    .foregroundStyle(
                        vaccine.isExpired ? Color.secondary : Color.primary
                    )
                
                Text(vaccine.type.rawValue)
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(
                        vaccine.isExpired ? Color.secondary : Color.accent
                    )
                
                Text(
                    vaccine.starts.formatted(
                        date: .abbreviated,
                        time: .omitted
                    )
                )
                .font(.caption)
                .fontDesign(.rounded)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if vaccine.isExpired {
                HStack {
                    Text("Expired")
                        .font(.subheadline.smallCaps())
                }
                .foregroundStyle(.secondary)
            } else {
                if vaccine.activeDays > 0 {
                    VStack {
                        Text(vaccine.activeDays.description)
                            .font(.title)
                            .fontDesign(.rounded)
                            .foregroundStyle(vaccine.activeDaysColor)
                        Text("More Days")
                            .font(.caption.smallCaps())
                            .bold()
                    }
                } else if vaccine.activeDays == 0 {
                    Text("Last Day")
                        .font(.caption.smallCaps())
                        .bold()
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview("Expired vaccine") {
    List {
        VaccineListRow(vaccine: Vaccine.sampleData[1])
    }
}

#Preview("Active vaccine") {
    List {
        VaccineListRow(vaccine: Vaccine.sampleData[0])
    }
}
