//
//  WhatsNew.swift
//  Pets
//
//  Created by MZiO on 30/9/24.
//

import SwiftUI

struct WhatsNewView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private func dismissView() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Version 1.1.1") {
                    UpdateView(
                        text: String(localized: "Improve app code internally for better performance.")
                    )
                    
                    UpdateView(text: String(localized: "Add some user interface twicks here and there for a smoother user experience."))
                }
                
                Section("Version 1.1") {
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
                    
                    UpdateView(text: String(localized: "New Support, What's New, and Rate this App views."))
                    
                    UpdateView(
                        text: String(
                            localized: "Some minor UI tweaks and error fixes."
                        )
                    )
                }
            }
            .navigationTitle("What's New")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
}

#Preview {
    WhatsNewView()
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
        }
    }
}
