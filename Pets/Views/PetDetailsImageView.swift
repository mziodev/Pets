//
//  PetDetailImage.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import PhotosUI
import SwiftUI

struct PetDetailsImageView: View {
    
    @Bindable var pet: Pet
    
    @State private var selectedImage: PhotosPickerItem?
    @State private var showingResizeImage: Bool = false
    
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
    
    var body: some View {
        VStack(spacing: 15) {
            PetImageView(pet: pet)

            if pet.image == nil {
                PhotosPicker(
                    "Add image",
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()
                )
            } else {
                HStack(spacing: 30) {
                    Button(action: resizeImage) {
                        Label("Resize", systemImage: "square.resize")
                    }
                    
                    Text("|")
                        .foregroundStyle(.secondary)
                    
                    Button(role: .destructive, action: removeImage) {
                        Label("Remove", systemImage: "trash")
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
    PetDetailsImageView(pet: SampleData.shared.petWithChipID)
}
