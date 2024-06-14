//
//  PetCardWeight.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardWeight: View {
    let pet: Pet
    
    private var currentWeight: Double {
        pet.reverseSortedWeights.first?.value ?? 0
    }
    
    private var weightString: String {
        currentWeight > 0 ? 
        "\(currentWeight.formatted()) \(Weight.units)" : "Add weight"
    }
    
    var body: some View {
        NavigationLink {
            WeightList(pet: pet)
        } label: {
            HStack {
                Spacer()
                
                Text("weight")
                    .font(.callout.lowercaseSmallCaps())
                    .foregroundStyle(.tint)
                
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
    PetCardWeight(pet: SampleData.shared.petWithChipID)
}

#Preview("Zero weight") {
    PetCardWeight(pet: SampleData.shared.petWithoutSpecies)
}
