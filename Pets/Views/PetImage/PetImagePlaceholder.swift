//
//  PetImagePlaceholder.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetImagePlaceholder: View {
    let species: PetSpecies
    let imageSize: PetImageSize
    
    private var accessibilityLabel: String {
        switch species {
        case .unknown:
            return "Paw print image"
        case .canine:
            return "Dog image"
        case .feline:
            return "Cat image"
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(
                    width: imageSize.rawValue,
                    height: imageSize.rawValue
                )
                .foregroundStyle(.gray.opacity(0.1))
            
            Image(systemName: species == .unknown ? "pawprint.fill" : "\(species.rawValue).fill")
                .font(.system(size: imageSize.rawValue * 0.45))
                .foregroundStyle(.tint)
                .accessibilityLabel(accessibilityLabel)
        }
    }
}

#Preview("No species, large") {
    PetImagePlaceholder(species: .unknown, imageSize: .large)
}

#Preview("Dog, small") {
    PetImagePlaceholder(species: .canine, imageSize: .small)
}
