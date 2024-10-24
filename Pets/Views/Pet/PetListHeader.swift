//
//  PetListHeader.swift
//  Pets
//
//  Created by MZiO on 24/10/24.
//

import SwiftUI

struct PetListHeader: View {
    let petNumber: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("\(petNumber) pets")
                .font(.caption)
        }
    }
}

#Preview {
    PetListHeader(petNumber: 5)
}
