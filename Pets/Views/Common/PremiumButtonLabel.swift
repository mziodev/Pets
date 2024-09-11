//
//  PremiumButton.swift
//  Pets
//
//  Created by MZiO on 5/9/24.
//

import SwiftUI

struct PremiumButtonLabel: View {
    let isPremium: Bool
    
    var body: some View {
        HStack(
            spacing: 5
        ) {
            Image(systemName: "crown.fill")
                .foregroundStyle(Gradient(colors: [.petsSunset, .petsFulvous]))
            
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
    PremiumButtonLabel(isPremium: false)
}
