//
//  NoPetsYet.swift
//  Petee
//
//  Created by MZiO on 28/5/24.
//

import SwiftUI

struct PetListNoPetsYet: View {
    var body: some View {
        ContentUnavailableView {
            Label("No pets yet", systemImage: "pawprint.fill")
                .foregroundStyle(.accent)
        } description: {
            Text("New pets you add will appear here.")
        }
    }
}


#Preview {
    PetListNoPetsYet()
}
