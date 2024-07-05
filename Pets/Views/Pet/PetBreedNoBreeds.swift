//
//  PetBreedNoBreeds.swift
//  Pets
//
//  Created by MZiO on 29/6/24.
//

import SwiftUI

struct PetBreedNoBreeds: View {
    var body: some View {
        ContentUnavailableView {
            Label("No breeds yet", systemImage: "pawprint.fill")
                .foregroundStyle(.petsAccentBlue)
        } description: {
            Text("You have to select your pet species first.")
        }
    }
}

#Preview {
    PetBreedNoBreeds()
}
