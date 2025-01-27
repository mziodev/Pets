//
//  PetImage.swift
//  Pets
//
//  Created by MZiO on 31/5/24.
//

import SwiftUI

struct PetImage: View {
    let pet: Pet
    
    private let imageSize = PetImageSize.medium.value
    
    var body: some View {
        if let imageData = pet.image,
            let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .scaleEffect(pet.imageScale)
                .offset(pet.imageOffset)
                .frame(maxHeight: imageSize)
                .clipShape(Circle())
                .accessibilityLabel("\(pet.name) photo")

        } else {
            PetImagePlaceholder(species: pet.species)
        }
    }
}

#Preview("Small image size") {
    PetImage(pet: SampleData.shared.petWithChipID)
}
