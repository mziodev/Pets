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


#Preview {
    WeightListChart(
        weights: SampleData.shared.petWithChipID.sortedWeights
    )
    .frame(height: 240)
    .padding()
}
