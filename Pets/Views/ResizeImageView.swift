//
//  ResizeImageView.swift
//  Pets
//
//  Created by MZiO on 24/9/24.
//

import SwiftUI

struct ResizeImageView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var pet: Pet
    
    @GestureState private var startOffset: CGSize? = nil
    @GestureState private var magnifyBy: CGFloat = 1.0
    
    @State private var newOffset: CGSize
    @State private var newScale: CGFloat
    
    private var magnification: some Gesture {
        MagnifyGesture()
            .updating($magnifyBy) { value, state, _ in
                state = value.magnification
            }
            .onEnded { value in
                newScale *= value.magnification
                pet.imageScale = newScale
            }
            .simultaneously(with: drag)
    }
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { offset in
                newOffset = startOffset ?? pet.imageOffset
                
                newOffset.width += offset.translation.width
                newOffset.height += offset.translation.height
            }
            .updating($startOffset) { value, startOffset, transaction in
                startOffset = startOffset ?? pet.imageOffset
            }
            .onEnded { _ in
                pet.updateImageOffset(offset: newOffset)
            }
    }
    
    private let imageSize = PetImageSize.medium.value
    
    init(pet: Pet) {
        self.pet = pet
        
        newOffset = pet.imageOffset
        newScale = pet.imageScale
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let imageData = pet.image,
                    let uiImage = UIImage(data: imageData)  {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(newScale * magnifyBy)
                        .offset(newOffset)
                }
                
                GeometryReader { geometry in
                    let centerX = (geometry.size.width / 2) - (imageSize / 2)
                    let centerY = (geometry.size.height / 2) - (imageSize / 2)
                    
                    Rectangle()
                        .symmetricDifference(
                            .circle.path(
                                in: CGRect(
                                    x: centerX,
                                    y: centerY,
                                    width: imageSize,
                                    height: imageSize
                                )
                            )
                        )
                        .fill(Color.black.opacity(0.5))
                        .ignoresSafeArea(edges: .bottom)
                }
            }
            .navigationTitle(
                pet.name != "" ? "Resize \(pet.name)'s Image" : "Resize Image"
            )
            .navigationBarTitleDisplayMode(.inline)
            .gesture(magnification)
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
    ResizeImageView(pet: SampleData.shared.petWithChipID)
}
