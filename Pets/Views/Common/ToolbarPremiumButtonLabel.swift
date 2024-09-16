//
//  PremiumButton.swift
//  Pets
//
//  Created by MZiO on 5/9/24.
//

import SwiftUI

struct ToolbarPremiumButtonLabel: View {
    let isPremium: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "crown.fill")
                .foregroundStyle(
                    Gradient(colors: [.petsSunset, .petsFulvous])
                )
                .accessibilityLabel("Gold crown")
            
            if !isPremium {
                Text("go Premium")
                    .bold()
            }
        }
        .font(.subheadline)
        .padding(.trailing, 10)
    }
}

#Preview {
    ToolbarPremiumButtonLabel(isPremium: false)
}
