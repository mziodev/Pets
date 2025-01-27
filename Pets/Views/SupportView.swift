//
//  Support.swift
//  Pets
//
//  Created by MZiO on 1/10/24.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.dismiss) private var dismiss
    
    let appVersionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        Link(
                            "mziodev@gmail.com",
                            destination: URLs.emailURL
                        )
                    } header: {
                        Text("Contact Us")
                    } footer: {
                        Text("Report a problem or just send us some feedback.")
                    }
                    
                    Section("Policies") {
                        Link(
                            "Privacy Policy",
                            destination: URLs.privacyPolicyURL
                        )
                        
                        Link(
                            "Terms of Service (EULA)",
                            destination: URLs.termsOfUseURL
                        )
                    }
                    
                    Section("About Pets") {
                        HStack {
                            Text("Version number:")
                            
                            Text(appVersionNumber)
                                .fontDesign(.rounded)
                                .bold()
                                .foregroundStyle(.petsFulvous)
                        }
                    }
                }
                .overlay(alignment: .bottom) {
                    Text("©\(Date.now.year) Mauricio Del Solar (MZiO)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Support")
            .toolbar {
                ToolbarItem {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
}

#Preview {
    SupportView()
}
