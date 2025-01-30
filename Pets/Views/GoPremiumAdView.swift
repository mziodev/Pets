//
//  GoPremiumAdView.swift
//  Pets
//
//  Created by MZiO on 11/9/24.
//

import SwiftUI

struct GoPremiumAdView: View {
    
    @Binding var showingPetsStore: Bool
    
    var adText: String
    
    let crownGoldGradient = Gradient(colors: [.petsSunset, .petsFulvous])
    
    private func showPetStore() {
        showingPetsStore = true
    }
    
    var body: some View {
        Section {
            VStack(spacing: 10) {
                Text(adText)
                    .font(.caption)
                
                Button(action: showPetStore) {
                    HStack {
                        Image(systemName: "crown.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(crownGoldGradient)
                            .accessibilityLabel("Gold crown symbol")
                        
                        Text("go Premium!")
                    }
                }
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .foregroundStyle(.white)
                .background(
                    .petsUCLABlue,
                    in: .rect(cornerRadius: 12)
                )
            }
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    List {
        GoPremiumAdView(
            showingPetsStore: .constant(false),
            adText: "Unlock Notes, Notifications and some other features with Pets Premium."
        )
    }
}
