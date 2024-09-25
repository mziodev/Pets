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
        VStack(spacing: 10) {
            PetImage(pet: pet)

            if pet.image == nil {
                PhotosPicker(
                    "Add image",
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                )
            } else {
                Button("Resize image") {
                    showingResizeImage = true
                }

                Button("Remove image", role: .destructive) {
                    withAnimation {
                        selectedImage = nil
                        pet.image = nil
                    }
                }
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
}

#Preview {
    PetDetailImage(pet: SampleData.shared.petWithChipID)
}
