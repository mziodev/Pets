//
//  CheckMarkLabel.swift
//  Pets
//
//  Created by MZiO on 28/1/25.
//

import SwiftUI

struct CheckMarkLabel: View {
    var body: some View {
        Label(
            "Green checkmark",
            systemImage: "checkmark"
        )
        .labelStyle(.iconOnly)
        .foregroundStyle(.green)
    }
}

#Preview {
    CheckMarkLabel()
}
