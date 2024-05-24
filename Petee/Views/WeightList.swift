//
//  WeightList.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

import Charts
import SwiftData
import SwiftUI

enum TimePeriod: String, CaseIterable, Identifiable {
    case lastSixMonths = "Last 6 Months"
    case lastTwelveMonths = "Last 12 months"
    
    var id: Self { self }
}

struct WeightList: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var pet: Pet
    @State private var selectedTimePeriod: TimePeriod = .lastSixMonths
    
    private let lastSixMonthsRange = Date.now - (86400 * 180) ... Date.now
    private let lastTwelveMonthsRange = Date.now - (86400 * 365) ... Date.now
    
    private let floatStyle = FloatingPointFormatStyle<Float>()
        .rounded(rule: .down)
        .precision(.fractionLength(2))
    
    
    // MARK: - computed properties
    private var selectedRange: ClosedRange<Date> {
        let selectedRange: ClosedRange<Date>
        
        switch selectedTimePeriod {
        case .lastSixMonths:
            selectedRange = lastSixMonthsRange
        case .lastTwelveMonths:
            selectedRange = lastTwelveMonthsRange
        }
        
        return selectedRange
    }
    
    var scrollPositionStartString: String {
        pet.reverseSortedWeights.last!.date.formatted(.dateTime.month().day())
    }
    
    var scrollPositionEndString: String {
        pet.reverseSortedWeights.first!.date.formatted(.dateTime.month().day().year())
    }
    
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Time Period", selection: $selectedTimePeriod.animation()) {
                ForEach(TimePeriod.allCases.reversed()) { period in
                    Text(period.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Average weight")
                .font(.callout)
                
                Text("\(pet.averageWeightIn(range: selectedRange).formatted(floatStyle))kg")
                    .font(.title)
                    .bold()
                
                Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .padding([.horizontal, .top])
            
            PetWeightChart(weights: pet.getSortedWeights(in: selectedRange))
                .frame(height: 240)
                .padding(.horizontal)
            
            List {
                ForEach(pet.reverseSortedWeights) { weight in
                    HStack {
                        Text(weight.date.formatted(date: .complete, time: .omitted))
                        
                        Spacer()
                        
                        Text("\(weight.value.formatted()) kg")
                            .bold()
                    }
                }
            }
            .navigationTitle("\(pet.name) weight list")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func getAverageWeight(in weights: [Weight]) -> Float {
        var totalWeight:Float = 0
        
        for weight in weights {
            totalWeight += weight.value
        }
        
        return totalWeight / Float(weights.count)
    }
}

#Preview {
    NavigationStack {
        WeightList(pet: SampleData.shared.pet)
    }
}
