//
//  PremiumButton.swift
//  Pets
//
//  Created by MZiO on 5/9/24.
//

import SwiftUI

struct PremiumButtonLabel: View {
    var body: some View {
        HStack(
            spacing: 5
        ) {
            Image(systemName: "crown")
            
            Text("Premium")
                .bold()
        }
        .font(.subheadline)
        .padding(.trailing, 10)
    }
}

#Preview {
    PremiumButtonLabel()
}
