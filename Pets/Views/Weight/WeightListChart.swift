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
                        "Date",
                        weight.date.monthAndDay
                    ),
                    y: .value("Weight", weight.value)
                )
            }
            
            if weights.count > 1 {
                RuleMark(
                    y: .value("Average", weights.averaging())
                )
                .foregroundStyle(.petsMediumGold)
                .annotation(position: .top, alignment: .leading) {
                    Text("Average")
                        .foregroundStyle(.petsMediumGold)
                        .font(.caption2.smallCaps())
                        .fontDesign(.rounded)
                        .bold()
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: weights.count)
        .foregroundStyle(.accent)
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
