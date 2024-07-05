//
//  WeightListNoWeight.swift
//  Pets
//
//  Created by MZiO on 26/6/24.
//

import SwiftUI

struct WeightListNoWeight: View {
    var body: some View {
        ContentUnavailableView {
            Label("No weights yet", systemImage: "scalemass")
                .foregroundStyle(.petsAccentBlue)
        } description:  {
            Text("Tap on the Plus button to add a new weight.")
                .padding(.top, 5)
        }
    }
}

#Preview {
    WeightListNoWeight()
}
