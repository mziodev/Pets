//
//  DewormingTreatmentListNoTreatment.swift
//  Pets
//
//  Created by MZiO on 25/6/24.
//

import SwiftUI

struct DewormingTreatmentListEmpty: View {
    var body: some View {
        ContentUnavailableView {
            Label("No treatments yet", systemImage: "ant")
                .foregroundStyle(.accent)
        } description: {
            Text("Tap the plus button to add a new deworming treatment.")
        }
    }
}

#Preview {
    DewormingTreatmentListEmpty()
}
