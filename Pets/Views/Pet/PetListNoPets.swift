//
//  PetListNoPets.swift
//  Petee
//
//  Created by MZiO on 28/5/24.
//

import SwiftUI

struct PetListNoPets: View {
    var body: some View {
        ContentUnavailableView {
            Label("No pets yet", systemImage: "pawprint.fill")
                .foregroundStyle(.accent)
        } description: {
            Text("Tap on the button '+' for add a new pet.")
        }
    }
}

#Preview {
    PetListNoPets()
}
