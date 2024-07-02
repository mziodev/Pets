//
//  VaccineNoVaccines.swift
//  Pets
//
//  Created by MZiO on 2/7/24.
//

import SwiftUI

struct VaccineNoVaccines: View {
    var body: some View {
        ContentUnavailableView {
            Label("No vaccines yet", systemImage: "syringe")
                .foregroundStyle(.petsAccentBlue)
        } description: {
            Text("Tap on the plus button to add new vaccines.")
        }
    }
}

#Preview {
    VaccineNoVaccines()
}
