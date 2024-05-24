//
//  GenericPetImage.swift
//  Petee
//
//  Created by Mauricio dSR on 24/5/24.
//

import SwiftUI


struct GenericPetImage: View {
    let petSpecies: PetSpecies
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 150)
                .foregroundStyle(.black.opacity(0.1))
            
            Image(systemName: "\(petSpecies.rawValue).fill")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
        }
        .padding(.top)
    }
}

#Preview {
    GenericPetImage(petSpecies: SampleData.shared.pet.type
    )
}
