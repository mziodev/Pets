//
//  NoPetsYet.swift
//  Petee
//
//  Created by MZiO on 28/5/24.
//

import SwiftUI

struct NoPetsYet: View {
    var body: some View {
        ContentUnavailableView {
            Label("No pets yet", systemImage: "dog.fill")
                .foregroundStyle(.tint)
        } description: {
            Text("New pets you add will appear here.")
        }
    }
}

#Preview {
    NoPetsYet()
}
