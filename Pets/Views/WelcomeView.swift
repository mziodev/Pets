//
//  Welcome.swift
//  Pets
//
//  Created by MZiO on 13/9/24.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var isFirstStart: Bool
    
    func continueToApp() {
        isFirstStart = false
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 30) {
                    Feature(
                        symbolName: "person.text.rectangle.fill",
                        symbolColor: .petsCelestialBlue,
                        title: String(localized: "Create their identities"),
                        text: String(localized: "Fill their personal cards up with their names, breeds, birthdays, Microchip info...")
                    )
                    
                    Feature(
                        symbolName: "stethoscope",
                        symbolColor: .red,
                        title: String(localized: "Take care of your pets"),
                        text: String(localized: "Take control of their weight, their regular deworming treatments, and vaccines.")
                    )
                    
                    Feature(
                        symbolName: "calendar.badge.clock",
                        symbolColor: .petsFulvous,
                        title: String(localized: "Don't miss anything"),
                        text: String(localized: "Write down any weight, vaccine or deworming treatment detail so you don't miss anything, and configure notifications so you don't forget any important thing.*")
                    )
                }
                .padding(.top, 30)
                
                Spacer()
                
                VStack {
                    Text("*Some features are only available on Pets Premium.")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                        .padding()
                    
                    Button("Continue", action: continueToApp)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .foregroundStyle(.white)
                        .background(
                            .petsUCLABlue,
                            in: .rect(cornerRadius: 12)
                        )
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            .padding()
            .navigationTitle("Welcome to Pets")
        }
    }
}

#Preview {
    WelcomeView(isFirstStart: .constant(true))
}

struct Feature: View {
    let symbolName: String
    let symbolColor: Color
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .frame(width: 70)
                .font(.system(size: 40))
                .foregroundStyle(symbolColor)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.headline)
                
                Text(text)
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
            }
        }
    }
}

