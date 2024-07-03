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
            Text(weight.date.formatted(date: .complete, time: .omitted))
                .font(.callout)
            
            Spacer()
            
            Text("\(weight.value.formatted()) \(Weight.units)")
                .font(.headline)
                .fontDesign(.rounded)

        }
    }
}

#Preview {
    List {
        WeightListRow(
            weight: SampleData.shared.petWithChipID.sortedWeights[2]
        )
    }
}
