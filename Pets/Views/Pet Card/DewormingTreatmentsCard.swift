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
                if let lastActiveTreatment =  pet.unwrappedDewormingTreatments.lastActive {
                    Text("Active")
                        .font(.caption.smallCaps())
                    
                    Text(lastActiveTreatment.name)
                        .font(.headline)
                    
                    VStack(alignment: .center){
                        HStack {
                            Text("Days to expire")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text("\(lastActiveTreatment.activeDays)")
                                .font(.largeTitle)
                                .bold()
                                .fontDesign(.serif)
                                .foregroundStyle(
                                    lastActiveTreatment.activeDaysColor
                                )
                        }
                    }
                    
                    Spacer()
                } else {
                    HStack {
                        Text("No active deworming treatments.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Image(systemName: "ant.fill")
                            .font(.title3)
                            .foregroundStyle(.red)
                    }
                }
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
