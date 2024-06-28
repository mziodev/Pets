//
//  PetCardName.swift
//  Pets
//
//  Created by MZiO on 26/6/24.
//

import SwiftUI

struct PetCardName: View {
    let name: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Name")
                .font(.callout.smallCaps())
                .foregroundStyle(.accent)
            
            Text(name)
                .font(.largeTitle.bold())
                .fontDesign(.serif)
            
            Spacer()
        }
    }
}

#Preview {
    PetCardName(name: "Chicho")
}
