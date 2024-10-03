//
//  WeightListRow.swift
//  Pets
//
//  Created by MZiO on 12/6/24.
//

import SwiftUI

struct WeightListRow: View {
    let weight: Weight
    
    private var weightFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 3
        numberFormatter.maximumFractionDigits = 3
        
        return numberFormatter
    }

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
            
            Text(weight.value as NSNumber, formatter: weightFormatter)
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
