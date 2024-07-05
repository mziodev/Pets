//
//  DewormingTreatmentListNoTreatment.swift
//  Pets
//
//  Created by MZiO on 25/6/24.
//

import SwiftUI

struct DewormingTreatmentListNoTreatment: View {
    var body: some View {
        ContentUnavailableView {
            Label("No treatments yet", systemImage: "ant")
                .foregroundStyle(.petsAccentBlue)
        } description: {
            Text("Tap the plus button to add a new deworming treatment.")
        }
    }
}

#Preview {
    DewormingTreatmentListNoTreatment()
}
