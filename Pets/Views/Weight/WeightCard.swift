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
                
                Spacer()
                
                if pet.unwrappedWeights.currentWeight.isZero {
                    VStack {
                        Text("No data yet.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    VStack {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(
                                String(
                                    format: "%.3f",
                                    pet.unwrappedWeights.currentWeight
                                )
                            )
                            .font(.largeTitle)
                            .bold()
                            .fontDesign(.serif)
                            .foregroundStyle(.accent)
                            
                            Text(Format.weightUnits)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
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
    WeightCard(pet: SampleData.shared.petWithChipID)
}
