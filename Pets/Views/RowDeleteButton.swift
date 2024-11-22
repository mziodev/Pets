//
//  RowDeleteButton.swift
//  Pets
//
//  Created by MZiO on 23/8/24.
//

import SwiftUI

struct RowDeleteButton: View {
    let title: String
    
    @Binding var showingAlert: Bool
    
    var body: some View {
        Section {
            HStack {
                Spacer()
                
                Button(
                    title,
                    role: .destructive,
                    action: activeShowingAlert
                )
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .foregroundStyle(.white)
                .background(Color.red)
                .clipShape(.rect(cornerRadius: 16))
                
                Spacer()
            }
        }
        .listRowBackground(Color.clear)
    }
    
    private func activeShowingAlert() {
        showingAlert = true
    }
}

#Preview {
    List {
        RowDeleteButton(
            title: "Delete Item",
            showingAlert: .constant(false)
        )
    }
}
