//
//  ChipBarcode.swift
//  Petee
//
//  Created by MZiO on 27/5/24.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct PetChipIDBarcode: View {
    @Environment(\.dismiss) var dismiss
    
    let chipID: String
    
    @State private var currentScreenBrightness: CGFloat?
    
    var barcodeImage: UIImage? {
        generateBarcode(from: chipID)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let barcodeImage {
                    VStack {
                        Image(uiImage: barcodeImage)
                            .interpolation(.none)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 600)
                            .clipShape(.rect(cornerRadius: 20))
                        
                        Text(chipID)
                            .font(.title)
                    }
                    .rotationEffect(Angle(degrees: 90))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear(perform: enableFullScreenBrightness)
                    .onDisappear(perform: restoreScreenBrightness)
                } else {
                    VStack {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 100))
                        
                        Text("Barcode reading error, try again")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Chip ID Barcode")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    /// Generates a UIImage representing a Code 128 barcode from a given string.
    ///
    /// - parameter from: The string to encode as a barcode.
    ///
    /// - returns: A UIImage instance with the generated barcode, or `nil` if the barcode 
    /// cannot be generated.
    ///
    /// - note: This function uses the `CIContext` and `CIFilter` classes to generate 
    /// the barcode image.
    private func generateBarcode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.code128BarcodeGenerator()
        
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(
                outputImage,
                from: outputImage.extent
            ) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return nil
    }
    
    private func enableFullScreenBrightness() {
        currentScreenBrightness = UIScreen.main.brightness
        
        withAnimation {
            UIScreen.main.brightness = 1.0
        }
    }
    
    private func restoreScreenBrightness() {
        if let currentScreenBrightness = currentScreenBrightness {
            withAnimation {
                UIScreen.main.brightness = currentScreenBrightness
            }
        }
    }
}

#Preview("With barcode") {
    PetChipIDBarcode(chipID: "981098108464559")
}

#Preview("Without barcode") {
    PetChipIDBarcode(chipID: "")
}
