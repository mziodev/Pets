//
//  WeightCard.swift
//  Pets
//
//  Created by MZiO on 27/9/24.
//

import SwiftUI

struct WeightCard: View {
    let pet: Pet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Weight")
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
                Text("Last")
                    .font(.caption.smallCaps())
                if pet.unwrappedWeights.currentWeight.isZero {
                    Text("No data yet")
                        .foregroundStyle(.secondary)
                } else {
                    Text(
                        String(
                            format: "%.3f %@",
                            pet.unwrappedWeights.currentWeight,
                            Format.weightUnits
                        )
                    )
                    .font(.title)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundStyle(.accent)
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
    WeightCard(pet: SampleData.shared.petWithChipID)
}
