//
//  WeightList.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

import Charts
import SwiftData
import SwiftUI

struct WeightList: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var pet: Pet
    @State var scrollPositionStart: Date = .now
    
    
    // MARK: - computed properties
    
    private var scrollPositionEnd: Date {
        scrollPositionStart.addingTimeInterval(3600 * 24 * 30)
    }
    
    private var scrollPositionStartString: String {
        scrollPositionStart.formatted(.dateTime.month().day())
    }
    
    private var scrollPositionEndString: String {
        scrollPositionEnd.formatted(.dateTime.month().day().year())
    }
    
    init(pet: Pet) {
        self.pet = pet
        self.scrollPositionStart = pet.weights.last!.date.addingTimeInterval(-1 * 3600 * 24 * 30)
    }
    
    
    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
//                Text(
//                    "Average: \(pet.averageWeightInPeriod(in: scrollPositionStart...scrollPositionEnd).formatted()) kg"
//                )
//                .font(.headline)
                
                Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .padding([.horizontal, .top])
            
            PetWeightChart(pet: pet, scrollPosition: $scrollPositionStart)
                .frame(height: 240)
                .padding(.horizontal)
            
            List {
                ForEach(pet.sortedWeights) { weight in
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

struct PetWeightChart: View {
    let pet: Pet
    
    @Binding var scrollPosition: Date
    
    var body: some View {
        Chart {
            ForEach(pet.weights) { weight in
                BarMark(
                    x: .value("Date", weight.date),
                    y: .value("Weight (kg.)", weight.value)
                )
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 3600 * 24 * 30)
        .chartScrollTargetBehavior(
            .valueAligned(
                matching: .init(hour: 0),
                majorAlignment: .matching(.init(day: 1))
            )
        )
        .chartScrollPosition(x: $scrollPosition)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 15)) {
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
    }
}
