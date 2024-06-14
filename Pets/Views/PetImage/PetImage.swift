//
//  PetImage.swift
//  Pets
//
//  Created by MZiO on 31/5/24.
//

import SwiftUI

struct PetImage: View {
    let pet: Pet
    let imageSize: PetImageSize
    
    var body: some View {
        if let imageData = pet.image,
            let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(
                    width: imageSize.rawValue,
                    height: imageSize.rawValue
                )
                .clipShape(Circle())

        } else {
            PetImagePlaceholder(
                species: pet.species,
                imageSize: imageSize
            )
        }
    }
}


// MARK: - previews
#Preview("Small image size") {
    PetImage(pet: SampleData.shared.petWithChipID, imageSize: .small)
}

#Preview("Large image size") {
    PetImage(pet: SampleData.shared.petWithChipID, imageSize: .large)
}
