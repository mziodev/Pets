//
//  Welcome.swift
//  Pets
//
//  Created by MZiO on 13/9/24.
//

import SwiftUI

struct Welcome: View {
    @Binding var isFirstStart: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Welcome to Pets")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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
                    
                    Spacer()
                    
                    Text("*Some features are only available on Pets Premium.")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                        .padding()
                }
            }
            
            Button("Continue", action: goToApp)
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .foregroundStyle(.white)
                .background(
                    .petsUCLABlue,
                    in: .rect(cornerRadius: 16)
                )
                .padding(.horizontal)
                .padding(.bottom)
        }
        .padding()
    }
    
    func goToApp() { isFirstStart = false }
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

#Preview {
    Welcome(isFirstStart: .constant(true))
}

