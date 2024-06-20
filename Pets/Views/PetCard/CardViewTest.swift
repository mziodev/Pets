//
//  CardViewTest.swift
//  Pets
//
//  Created by MZiO on 17/6/24.
//

import SwiftUI

struct CardViewTest: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: 350, maxHeight: 600)
                .foregroundStyle(.blue.opacity(0.2))
                .clipShape(.rect(cornerRadius: 12))
                .shadow(radius: 5, x: 1, y: 3)
            
            Text("Hello, World!")
        }
    }
}

#Preview {
    CardViewTest()
}
