//
//  WeightList.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

import SwiftData
import SwiftUI

struct WeightList: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var selectedTimePeriod: TimePeriod = .lastSixMonths
    @State private var showingAddWeightSheet: Bool = false
    
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
                                                .decimalFormatter(for: 2)
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
                        
                        WeightListChart(weights: selectedDateRangeWeights)
                            .frame(height: 240)
                            .padding(.horizontal, 5)
                    }
                    .padding(.horizontal)
                    .padding(.top, 2)
                    
                    List {
                        Section("Weight List (\(Weight.units))") {
                            ForEach(pet.unwrappedWeights.reverseSortedByDate) { weight in
                                NavigationLink {
                                    WeightDetail(pet: pet, weight: weight)
                                } label: {
                                    WeightListRow(weight: weight)
                                }
                            }
                        }
                    }
                } else {
                    WeightListEmpty()
                }
            }
            .navigationTitle("\(pet.name)'s weight list")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddWeightSheet) {
                WeightDetail(pet: pet, isNew: true)
            }
            .toolbar {
                ToolbarItem {
                    Button { showingAddWeightSheet.toggle() } label: {
                        Label("Add weight", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func dismissView() { dismiss() }
}

#Preview("Existing Weight List") {
    WeightList(pet: SampleData.shared.petWithoutChipID)
}

#Preview("Empty Weight List") {
    WeightList(pet: SampleData.shared.petWithoutSpecies)
}
