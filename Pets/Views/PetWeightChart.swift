//
//  PetWeightChart.swift
//  Petee
//
//  Created by MZiO on 23/5/24.
//

/*
 TODO:
 Day format and check weights tags over bars
 */

import Charts
import SwiftUI

struct PetWeightChart: View {
    let weights: [Weight]
    
    var body: some View {
        Chart {
            ForEach(weights) { weight in
                BarMark(
                    x: .value(
                        "Month",
                        weight.date.formatted(date: .abbreviated, time: .omitted)
                    ),
                    y: .value("Weight", weight.value)
                )
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: weights.count)
    }
}

#Preview {
    PetWeightChart(weights: SampleData.shared.petWithChipID.sortedWeights)
        .frame(height: 240)
        .padding()
}
