//
//  PetCardWeight.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardWeight: View {
    let pet: Pet
    
    var body: some View {
        if pet.unwrappedWeights.currentWeight > 0 {
            HStack {
                Spacer()
                
                Text("Weight")
                    .font(.callout.lowercaseSmallCaps())
                    .foregroundStyle(.accent)
                
                Text(
                    pet.unwrappedWeights.currentWeight as NSNumber,
                    formatter: Weight.decimalFormatter(for: 3)
                )
                .font(.largeTitle)
                .bold()
                .fontDesign(.serif)
                
                Spacer()
            }
        }
    }
}

#Preview("Normal weight") {
    PetCardWeight(
        pet: SampleData.shared.petWithChipID
    )
}

#Preview("Zero weight") {
    PetCardWeight(
        pet: SampleData.shared.petWithoutSpecies
    )
}
