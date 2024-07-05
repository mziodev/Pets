//
//  PetDetailImage.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import PhotosUI
import SwiftUI

struct PetDetailImage: View {
    @Bindable var pet: Pet
    
    @State private var selectedImage: PhotosPickerItem?
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                PetImage(pet: pet, imageSize: .small)
                
                PhotosPicker(
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text(pet.image != nil ? "Change photo" : "Add photo")
                        .foregroundStyle(
                            pet.image != nil ? .primary : Color.accent
                        )
                }
                
                if pet.image != nil {
                    Button("Remove photo", role: .destructive) {
                        withAnimation {
                            selectedImage = nil
                            pet.image = nil
                        }
                    }
                }
            }
            
            Spacer()
        }
        .task(id: selectedImage) {
            if let data = try? await selectedImage?.loadTransferable(
                type: Data.self
            ) {
                pet.image = data
            }
        }
    }
}

#Preview {
    PetDetailImage(pet: SampleData.shared.petWithChipID)
}
