//
//  WeightListRow.swift
//  Pets
//
//  Created by MZiO on 12/6/24.
//

import SwiftUI

struct WeightListRow: View {
    let weight: Weight

    var body: some View {
        HStack {
            Text(
                weight.date.formatted(
                    date: .abbreviated,
                    time: .omitted
                )
            )
            .font(.callout)
            
            Spacer()
            
            Text(
                String(
                    format: "%.3f",
                    locale: Locale.current,
                    weight.value
                )
            )
            .font(.headline)
            .fontDesign(.rounded)
            .foregroundStyle(.petsFulvous)
        }
    }
}

#Preview {
    List {
        WeightListRow(
            weight: SampleData.shared.petWithChipID.unwrappedWeights.sortedByDate[2]
        )
    }
}
