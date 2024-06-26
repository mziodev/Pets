//
//  WeightListNoWeight.swift
//  Pets
//
//  Created by MZiO on 26/6/24.
//

import SwiftUI

struct WeightListNoWeight: View {
    var body: some View {
        ContentUnavailableView(
            "No weights yet",
            systemImage: "scalemass",
            description: Text("Tap on the Plus button to add a new weight.")
        )
    }
}

#Preview {
    WeightListNoWeight()
}
