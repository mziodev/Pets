//
//  PetWeightChart.swift
//  Petee
//
//  Created by MZiO on 23/5/24.
//

import Charts
import SwiftUI

struct WeightListChart: View {
    let weights: [Weight]
    
    
    var body: some View {
        Chart {
            ForEach(weights) { weight in
                BarMark(
                    x: .value(
                        "Month",
                        weight.date.formatted(
                            .dateTime.month().day()
                        )
                    ),
                    y: .value("Weight", weight.value)
                )
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: weights.count)
        .foregroundStyle(.petsAccentBlue)
    }
}

#Preview("Less than 3 weights") {
    WeightListChart(
        weights: SampleData.shared.petWithExpiredVaccines.unwrappedWeights.sortedByDate
    )
    .frame(height: 240)
    .padding()
}

#Preview("More than 3 weights") {
    WeightListChart(
        weights: SampleData.shared.petWithoutChipID.unwrappedWeights.sortedByDate
    )
    .frame(height: 240)
    .padding()
}
