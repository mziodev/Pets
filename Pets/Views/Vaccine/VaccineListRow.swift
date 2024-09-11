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
    
    private var isVaccineExpired: Bool {
        vaccine.activeDays < 0
    }
    
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
                        isVaccineExpired ? Color.secondary : Color.primary
                    )
                
                Text(vaccine.type.rawValue)
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(
                        isVaccineExpired ? Color.secondary : Color.accentColor
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
            
            if !isVaccineExpired {
                if vaccine.activeDays > 0 {
                    VStack {
                        Text(vaccine.activeDays.description)
                            .font(.title)
                            .fontDesign(.rounded)
                            .foregroundStyle(activeDaysColor)
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
