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
                                .foregroundStyle(
                                    Gradient(colors: [.petsSunset, .petsFulvous])
                                )
                            
                            Text("go Premium!")
                        }
                        .bold()
                    }
                    .font(.title3.bold())
                    .padding(.vertical, 12)
                    .padding(.horizontal, 50)
                    .foregroundStyle(.white)
                    .background(
                        .petsUCLABlue,
                        in: .rect(cornerRadius: 16)
                    )
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
