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
    @State private var showingResizeImage: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            PetImage(pet: pet)

            if pet.image == nil {
                PhotosPicker(
                    "Add image",
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                )
            } else {
                Button("Resize image", action: resizeImage)

                Button(
                    "Remove image",
                    role: .destructive,
                    action: removeImage
                )
            }
        }
        .sheet(isPresented: $showingResizeImage) {
            ResizeImage(pet: pet)
        }
        .task(id: selectedImage) {
            if let data = try? await selectedImage?.loadTransferable(
                type: Data.self
            ) {
                pet.image = data
            }
        }
    }
    
    private func resizeImage() {
        showingResizeImage = true
    }
    
    private func removeImage() {
        selectedImage = nil
        
        withAnimation {
            pet.image = nil
            pet.imageScale = 1
            pet.updateImageOffset(offset: .zero)
        }
    }
}

#Preview {
    PetDetailImage(pet: SampleData.shared.petWithChipID)
}
