//
//  PetImage.swift
//  Pets
//
//  Created by MZiO on 31/5/24.
//

import SwiftUI

struct PetImageView: View {
    
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
            Circle()
                .frame(width: imageSize, height: imageSize)
                .foregroundStyle(.accent)
                .overlay {
                    Image(systemName: "\(pet.species.symbol).fill")
                        .font(.system(size: imageSize * 0.5))
                        .foregroundStyle(.white)
                        .accessibilityLabel(
                            pet.species.symbolLocalizedDescription
                        )
                }
        }
    }
}

#Preview("Small image size") {
    PetImageView(pet: SampleData.shared.petWithChipID)
}
