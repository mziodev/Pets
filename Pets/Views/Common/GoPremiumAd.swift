//
//  GoPremiumAd.swift
//  Pets
//
//  Created by MZiO on 11/9/24.
//

import SwiftUI

struct GoPremiumAd: View {
    @Binding var showingPetsStore: Bool
    
    var adText: String
    
    var body: some View {
        Section {
            VStack {
                Text(adText)
                    .font(.caption)
                
                HStack {
                    Spacer()
                    
                    Button {
                        showingPetsStore = true
                    } label: {
                        HStack {
                            Image(systemName: "crown.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Gradient(colors: [.petsLightGold, .petsMediumGold]))
                            
                            Text("go Premium!")
                        }
                        .bold()
                    }
                    .frame(width: 200, height: 44)
                    .background(.accent)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 30))
                    .padding(.top)
                    
                    Spacer()
                }
            }
            .padding(.vertical, 10)
        }
    }
}

#Preview {
    List {
        GoPremiumAd(
            showingPetsStore: .constant(false),
            adText: "Unlock Notes, Notifications and some other features with Pets Premium."
        )
    }
}
