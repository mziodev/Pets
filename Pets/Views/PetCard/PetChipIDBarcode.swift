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
    
    var barcodeImage: UIImage? {
        generateBarcode(from: chipID)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let barcodeImage {
                    Image(uiImage: barcodeImage)
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: chipID.isEmpty ? 100 : 500)
                } else {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 100))
                }
                
                Text(
                    chipID.isEmpty ? 
                    "Barcode reading error, try again" : chipID
                )
                .font(chipID.isEmpty ? .callout : .title2)
                    .offset(y: chipID.isEmpty ? 5 : -20)
            }
            .navigationTitle("Chip ID Barcode")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .rotationEffect(Angle(degrees: 90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .foregroundStyle(.black)
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
    func generateBarcode(from string: String) -> UIImage? {
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
}

#Preview("With barcode") {
    PetChipIDBarcode(chipID: "123456789098765")
}

#Preview("Without barcode") {
    PetChipIDBarcode(chipID: "")
}
