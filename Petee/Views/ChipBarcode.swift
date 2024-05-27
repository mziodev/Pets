//
//  ChipBarcode.swift
//  Petee
//
//  Created by MZiO on 27/5/24.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct ChipBarcode: View {
    let chipID: String
    
    var body: some View {
        VStack {
            Image(uiImage: generateBarcode(from: chipID))
                .interpolation(chipID.isEmpty ? .low : .none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: chipID.isEmpty ? 100 : 500)
            
            Text(
                chipID.isEmpty ? "Barcode reading error, try again" : chipID
            )
            .font(chipID.isEmpty ? .callout : .title2)
                .offset(y: chipID.isEmpty ? 5 : -20)
        }
        .rotationEffect(Angle(degrees: 90))
    }
    
    func generateBarcode(from string: String) -> UIImage {
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
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    ChipBarcode(chipID: "")
}
