//
//  PetListSelectAPet.swift
//  Pets
//
//  Created by MZiO on 25/10/24.
//

import SwiftUI

struct PetListSelectAPet: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "pawprint.fill")
                .font(.system(size: 70))
                .foregroundStyle(.petsCelestialBlue)
            
            Text("Select a pet to show its card.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PetListSelectAPet()
}
