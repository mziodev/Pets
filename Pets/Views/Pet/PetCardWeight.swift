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
                
                Text("Weight")
                    .font(.callout.lowercaseSmallCaps())
                    .foregroundStyle(.accent)
                
                Text(weightString)
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
