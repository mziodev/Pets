//
//  PetCardBreed.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardBreed: View {
    let breed: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("Breed")
                .font(.callout.smallCaps())
                .foregroundStyle(.tint)
            
            Text(breed.isEmpty ? "Unknown" : breed)
                .font(.largeTitle.bold())
                .fontDesign(.serif)
                .minimumScaleFactor(0.5)
            
            Spacer()
        }
    }
}

#Preview("No breed") {
    PetCardBreed(breed: "")
}

#Preview("Jack Russell Terrier") {
    PetCardBreed(breed: "Jack Russell Terrier")
}

#Preview("Poodle, Toy") {
    PetCardBreed(breed: "Poodle, Toy")
}
