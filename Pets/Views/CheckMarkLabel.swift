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
            "Name verified checkmark",
            systemImage: "checkmark"
        )
        .labelStyle(.iconOnly)
        .foregroundStyle(.green)
    }
}

#Preview {
    CheckMarkLabel()
}
