//
//  VaccineListRow.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineListRow: View {
    let vaccine: Vaccine
    
    private let daysRange = 15...30
    
    var activeDaysColor: Color {
        if vaccine.activeDays < 15 {
            return .red
        } else if daysRange.contains(vaccine.activeDays) {
            return .yellow
        } else {
            return .green
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(vaccine.name)
                    .font(.headline)
                    .foregroundStyle(
                        vaccine.activeDays > 0 ? Color.primary : Color.secondary
                    )
                
                Text(vaccine.type.rawValue)
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(
                        vaccine.activeDays > 0 ? Color.petsAccentBlue : Color.secondary
                    )
                
                Text(
                    vaccine.date.formatted(
                        date: .abbreviated,
                        time: .omitted
                    )
                )
                .font(.caption)
                .fontDesign(.rounded)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if vaccine.activeDays > 0 {
                VStack {
                    Text(vaccine.activeDays.description)
                        .font(.title)
                        .fontDesign(.rounded)
                        .foregroundStyle(activeDaysColor)
                    Text("More days")
                        .font(.caption.smallCaps())
                        .bold()
                }
            } else {
                HStack {
                    Text("Expired")
                        .font(.subheadline.smallCaps())
                }
                .foregroundStyle(.secondary)
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
