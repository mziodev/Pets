//
//  PetImagePlaceholder.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetImagePlaceholder: View {
    let species: PetSpecies
    
    private let imageSize = PetImageSize.medium.value
    
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: imageSize, height: imageSize)
                .foregroundStyle(.accent)
            
            Image(systemName: "\(species.symbol).fill")
                .font(.system(size: imageSize * 0.5))
                .foregroundStyle(.white)
                .accessibilityLabel(
                    species.symbolLocalizedDescription
                )
        }
    }
}


#Preview("No species") {
    PetImagePlaceholder(species: .unknown)
}

#Preview("Dog") {
    PetImagePlaceholder(species: .cannine)
}

#Preview("Cat") {
    PetImagePlaceholder(species: .feline)
}
