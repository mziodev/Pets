//
//  PetCardChipID.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardChipID: View {
    let chipID: String
    
    var body: some View {
        if chipID.isEmpty {
            HStack {
                Spacer()
                
                Text("No chip")
                    .font(.callout.smallCaps())
                    .foregroundStyle(.accent)
                
                Spacer()
            }
        } else {
            NavigationLink {
                PetChipBarcode(chipID: chipID)
            } label: {
                HStack {
                    Spacer()
                    
                    Text("Chip ID")
                        .font(.callout.smallCaps())
                        .foregroundStyle(.accent)
                    
                    Text(chipID)
                        .fontDesign(.serif)
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview("No chip") {
    PetCardChipID(chipID: "")
}

#Preview("15 digits chip") {
    PetCardChipID(chipID: "123456789098765")
}

#Preview("9 digits chip") {
    PetCardChipID(chipID: "123456789")
}
