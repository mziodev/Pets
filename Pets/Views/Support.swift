//
//  Support.swift
//  Pets
//
//  Created by MZiO on 1/10/24.
//

import SwiftUI

struct Support: View {
    @Environment(\.dismiss) private var dismiss
    
    let appVersionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    
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
                        HStack {
                            Spacer()
                            
                            Text("Report a problem or just send us some feedback.")
                        }
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
                        AppInfo(
                            text: String(localized: "Version number:"),
                            number: appVersionNumber
                        )
                        
                        AppInfo(
                            text: String(localized: "Build number:"),
                            number: appBuildNumber
                        )
                    }
                }
                .overlay {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Text("©2024 Mauricio Del Solar (MZiO)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                        }
                    }
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

struct AppInfo: View {
    let text: String
    let number: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(text)
            
            Text(number)
                .fontDesign(.rounded)
                .bold()
                .foregroundStyle(.petsFulvous)
        }
    }
}

#Preview {
    Support()
}
