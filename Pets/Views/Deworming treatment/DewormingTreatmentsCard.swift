//
//  DewormingTreatmentsCard.swift
//  Pets
//
//  Created by MZiO on 28/9/24.
//

import SwiftUI

struct DewormingTreatmentsCard: View {
    let pet: Pet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Deworming Treatments")
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.accent)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Active")
                    .font(.caption.smallCaps())
                
                Spacer()
                
                if let lastActiveTreatment =  pet.unwrappedDewormingTreatments.lastActive {
                    Text(lastActiveTreatment.name)
                        .font(.callout)
                        .bold()
                    
                    VStack {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\(lastActiveTreatment.activeDays)")
                                .font(.largeTitle)
                                .bold()
                                .fontDesign(.serif)
                                .foregroundStyle(
                                    lastActiveTreatment.activeDaysColor
                                )
                            
                            Text("More days")
                                .font(.caption.smallCaps())
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    VStack {
                        Text("No data yet.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
            }
            .frame(height: 80)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .background(.thickMaterial)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    DewormingTreatmentsCard(pet: SampleData.shared.petWithExpiredVaccines)
}
