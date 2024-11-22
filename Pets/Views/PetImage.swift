//
//  PetImage.swift
//  Pets
//
//  Created by MZiO on 31/5/24.
//

import SwiftUI

struct PetImage: View {
    let pet: Pet
    
    private var imageSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            PetImageSize.medium.value * 1.2
        } else {
            PetImageSize.medium.value
        }
    }
    
    var body: some View {
        if let imageData = pet.image,
            let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(pet.imageScale)
                .offset(pet.imageOffset)
                .frame(width: imageSize, height: imageSize)
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
