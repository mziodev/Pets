//
//  PetImage.swift
//  Pets
//
//  Created by MZiO on 31/5/24.
//

import SwiftUI

enum PetImageSize: Double {
    case small = 150
    case large = 250
}

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
            ZStack {
                Circle()
                    .frame(width: imageSize.rawValue, height: imageSize.rawValue)
                    .foregroundStyle(.thickMaterial)
                
                Image(systemName: "\(pet.species.rawValue).fill")
                    .font(.system(size: imageSize.rawValue * 0.45))
                    .foregroundStyle(Color.accentColor)
            }
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
