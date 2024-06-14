//
//  PetListRow.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetListRow: View {
    let name: String
    let breed: String
    let speciesName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text(breed.isEmpty ? "Unknown breed" : breed)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "\(speciesName == "none" ? "pawprint" : speciesName).fill")
                .font(.title2)
        }
    }
}

#Preview("Dog") {
    PetListRow(name: "Ruffo", breed: "Labrador", speciesName: "dog")
        .padding()
}

#Preview("Cat") {
    PetListRow(name: "Luna", breed: "Main Coon", speciesName: "cat")
        .padding()
}

#Preview("No breed, no species") {
    PetListRow(name: "Roofus", breed: "", speciesName: "none")
        .padding()
}
