//
//  DeleteButton.swift
//  Pets
//
//  Created by MZiO on 23/8/24.
//

import SwiftUI

struct DeleteButton: View {
    let title: String
    
    @Binding var showingAlert: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(
                title,
                role: .destructive,
                action: activeShowingAlert
            )
            .padding(.top, 10)
            .padding(.bottom, 30)
        }
    }
    
    private func activeShowingAlert() {
        showingAlert = true
    }
}

#Preview {
    DeleteButton(
        title: "Delete Item",
        showingAlert: .constant(false)
    )
}
