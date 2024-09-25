//
//  ResizeImage.swift
//  Pets
//
//  Created by MZiO on 24/9/24.
//

import SwiftUI

struct ResizeImage: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @State var newOffset: CGSize
    @State var newScale: CGFloat
    
    private let imageSize = PetImageSize.medium.value
    
    init(pet: Pet) {
        self.pet = pet
        
        newOffset = pet.imageOffset
        newScale = pet.imageScale
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    if let imageData = pet.image,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(newScale)
                            .offset(newOffset)
                            .frame(height: imageSize)
                            .opacity(0.4)
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(newScale)
                            .offset(newOffset)
                            .mask(
                                Circle()
                                    .frame(
                                        width: imageSize,
                                        height: imageSize
                                    )
                            )
                            .gesture(
                                MagnifyGesture()
                                    .onChanged { scale in
                                        newScale = scale.magnification
                                    }
                                    .onEnded { _ in
                                        pet.imageScale = newScale
                                    }
                            )
                            .simultaneousGesture(
                                DragGesture()
                                    .onChanged { offset in
                                        newOffset = offset.translation
                                    }
                                    .onEnded { _ in
                                        pet.updateImageOffset(
                                            offset: newOffset
                                        )
                                    }
                            )
                    } else {
                        Text("No pet image available.")
                    }
                }
            }
            .navigationTitle("Resize \(pet.name)'s Image")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                print(pet.imageScale)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
}

#Preview {
    ResizeImage(pet: SampleData.shared.petWithChipID)
}
