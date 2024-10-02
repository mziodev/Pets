//
//  WhatsNew.swift
//  Pets
//
//  Created by MZiO on 30/9/24.
//

import SwiftUI

struct WhatsNew: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 50) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Version 1.1.0")
                            .font(.title)
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            UpdateView(
                                text: String(
                                    localized: "Added resize feature for images."
                                )
                            )
                            
                            UpdateView(
                                text: String(
                                    localized: "New Pet card with summary information about the last weight, deworming treatments, and vaccines."
                                )
                            )
                            
                            UpdateView(
                                text: String(
                                    localized: "Some minor UI tweaks and error fixes."
                                )
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(
                Gradient(
                    colors: [.accent.opacity(0), .accent.opacity(0.3)]
                )
            )
            .navigationTitle("What's new on Pets")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
}

struct UpdateView: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top ,spacing: 5) {
            Image(systemName: "checkmark.square.fill")
                .font(.title3)
                .bold()
                .foregroundStyle(.green)
            
            Text(text)
                .font(.subheadline)
                .padding(.top, 3)
        }
    }
}

#Preview {
    WhatsNew()
}
