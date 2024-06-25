//
//  PetCardWeight.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardWeight: View {
    let pet: Pet
    let currentWeight: Double
    
    @Binding var showingWeightDetail: Bool
    
    private var weightString: String {
        "\(currentWeight.formatted()) \(Weight.units)"
    }
    
    var body: some View {
        if currentWeight > 0 {
            HStack {
                Spacer()
                
                Text("weight")
                    .font(.callout.lowercaseSmallCaps())
                    .foregroundStyle(.accent)
                
                Text(weightString)
                    .font(currentWeight > 0 ? .largeTitle : .callout)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundStyle(
                        currentWeight > 0 ? .primary : Color.gray.opacity(0.5)
                    )
                
                Spacer()
            }
        }
    }
}

#Preview("Normal weight") {
    PetCardWeight(
        pet: SampleData.shared.petWithChipID,
        currentWeight: 3.75,
        showingWeightDetail: .constant(false)
    )
}

#Preview("Zero weight") {
    PetCardWeight(
        pet: SampleData.shared.petWithoutSpecies,
        currentWeight: 0,
        showingWeightDetail: .constant(false)
    )
}
