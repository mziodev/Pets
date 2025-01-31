//
//  WeightListView.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

import Charts
import SwiftData
import SwiftUI

struct WeightListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var selectedTimePeriod: TimePeriod = .lastSixMonths
    @State private var showingWeightDetailsView = false
    
    private var selectedDateRange: ClosedRange<Date> {
        selectedTimePeriod.dateValue ... .now
    }
    
    private var selectedDateRangeWeights: [Weight] {
        pet.unwrappedWeights.filteringAndSorting(in: selectedDateRange)
    }
    
    private var averageStartDate: Date {
        pet.unwrappedWeights
            .sortedByDate
            .first(where: { selectedDateRange.contains($0.date) })?.date
            ?? pet.unwrappedWeights.sortedByDate.first?.date
            ?? Date.now
    }
    
    private var averageEndDate: Date {
        pet.unwrappedWeights
            .sortedByDate
            .last(where: { selectedDateRange.contains($0.date) })?.date
            ?? pet.unwrappedWeights.sortedByDate.last?.date
            ?? Date.now
    }
    
    private var averageStartDateToString: String {
        averageStartDate.year != averageEndDate.year ? averageStartDate.monthDayYear : averageStartDate.monthAndDay
    }
    
    private func showWeightDetailsView() {
        showingWeightDetailsView = true
    }
    
    private func dismissView() { dismiss() }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if !pet.unwrappedWeights.isEmpty {
                    Picker(
                        "Time Period",
                        selection: $selectedTimePeriod.animation()
                    ) {
                        ForEach(
                            TimePeriod.allCases.reversed(),
                            id: \.self
                        ) { period in
                            Text(period.localizedDescription)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            if !selectedDateRangeWeights.isEmpty && selectedDateRangeWeights.count > 1 {
                                Text("Average Weight")
                            } else {
                                Text("No average yet")
                            }
                            
                            if selectedDateRangeWeights.isEmpty {
                                Text(
                                    "(Not enough data from \(selectedTimePeriod.localizedDescription))"
                                )
                                .font(.caption)
                            }
                            
                            Group {
                                if pet.unwrappedWeights.count > 1  && !selectedDateRangeWeights.isEmpty {
                                    HStack(spacing: 5) {
                                        Text(
                                            selectedDateRangeWeights
                                                .averaging() as NSNumber,
                                            formatter: Weight
                                                .decimalFormatter(
                                                    fractionDigits: 1
                                                )
                                        )
                                        
                                        Text(Weight.units)
                                    }
                                } else {
                                    Text("-")
                                }
                            }
                            .font(.largeTitle)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundStyle(.petsFulvous)
                            
                            Text("\(averageStartDateToString) – \(averageEndDate.monthDayYear)")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 5)
                        
                        WeightChart(weights: selectedDateRangeWeights)
                            .frame(height: 240)
                            .padding(.horizontal, 5)
                    }
                    .padding(.horizontal)
                    .padding(.top, 2)
                    
                    List {
                        Section("Weight List (\(Weight.units))") {
                            ForEach(pet.unwrappedWeights.reverseSortedByDate) { weight in
                                NavigationLink {
                                    WeightDetailsView(pet: pet, weight: weight)
                                } label: {
                                    WeightListRow(weight: weight)
                                }
                            }
                        }
                    }
                } else {
                    NoWeightsYetView()
                }
            }
            .navigationTitle("\(pet.name)'s weight list")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingWeightDetailsView) {
                WeightDetailsView(pet: pet, isNew: true)
            }
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: showWeightDetailsView) {
                        Label("Add weight", systemImage: "plus.circle.fill")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
        }
    }
}

#Preview("Existing Weight List") {
    WeightListView(pet: SampleData.shared.petWithoutChipID)
        .environmentObject(PetsStoreManager())
}

#Preview("Empty Weight List") {
    WeightListView(pet: SampleData.shared.petWithoutSpecies)
}

struct WeightChart: View {
    
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
                .foregroundStyle(.petsFulvous)
                .annotation(position: .top, alignment: .leading) {
                    Text("Average")
                        .foregroundStyle(.petsFulvous)
                        .font(.caption2.smallCaps())
                        .fontDesign(.rounded)
                        .bold()
                        .padding(.horizontal, 10)
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: weights.count)
        .foregroundStyle(.accent)
    }
}

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
                weight.value as NSNumber,
                formatter: Weight.decimalFormatter(fractionDigits: 3)
            )
            .font(.headline)
            .fontDesign(.rounded)
            .foregroundStyle(.petsFulvous)
        }
    }
}

struct NoWeightsYetView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No weights yet", systemImage: "scalemass")
                .foregroundStyle(.accent)
        } description:  {
            Text("Tap on the Plus button to add a new weight.")
                .padding(.top, 5)
        }
    }
}
