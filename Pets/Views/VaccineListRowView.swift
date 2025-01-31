//
//  VaccineListRowView.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineListRowView: View {
    
    let vaccine: Vaccine
    
    var body: some View {
        HStack {
            VaccineInfoView(vaccine: vaccine)
            
            Spacer()
            
            ActiveDaysView(vaccine: vaccine)
        }
    }
}

#Preview("Expired vaccine") {
    List {
        VaccineListRowView(vaccine: Vaccine.sampleData[1])
    }
}

#Preview("Active vaccine") {
    List {
        VaccineListRowView(vaccine: Vaccine.sampleData[0])
    }
}

struct VaccineInfoView: View {
    
    let vaccine: Vaccine
    
    var body: some View {
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
    }
}

struct ActiveDaysView: View {
    
    let vaccine: Vaccine
    
    var body: some View {
        VStack {
            if vaccine.isExpired {
                Text("Expired")
                    .font(.subheadline.smallCaps())
                    .foregroundStyle(.secondary)
            } else {
                if vaccine.activeDays > 0 {
                    VStack(spacing: 0) {
                        Text(vaccine.activeDays.description)
                            .font(.title)
                            .fontDesign(.serif)
                            .foregroundStyle(vaccine.activeDaysColor)
                        Text("More Days")
                            .font(.caption.smallCaps())
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
