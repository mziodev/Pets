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
                .foregroundStyle(Color.secondary.opacity(0.2))
            
            Image(systemName: "\(petSpecies.rawValue).fill")
                .font(.system(size: 60))
                .foregroundStyle(Color.accentColor)
        }
        .padding(.top)
    }
}

#Preview("Light mode") {
    GenericPetImage(petSpecies: SampleData.shared.pet.species)
}

#Preview("Dark mode") {
    GenericPetImage(petSpecies: SampleData.shared.pet.species)
        .preferredColorScheme(.dark)
}
