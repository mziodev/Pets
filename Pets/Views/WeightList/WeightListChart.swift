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

struct WeightListChart: View {
    let weights: [Weight]
    
    
    // MARK: - body
    var body: some View {
        Chart {
            ForEach(weights) { weight in
                BarMark(
                    x: .value(
                        "Month",
                        weight.date.formatted(.dateTime.month().day())
                    ),
                    y: .value("Weight", weight.value)
                )
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: weights.count)
    }
}


// MARK: - previews
#Preview {
    WeightListChart(
        weights: SampleData.shared.petWithChipID.sortedWeights
    )
    .frame(height: 240)
    .padding()
}
