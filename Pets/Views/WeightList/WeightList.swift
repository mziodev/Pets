//
//  WeightList.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

/*
 TODO
 Fix average weight, it show dots all the time. Check out the Locale option.
 */

import SwiftData
import SwiftUI

struct WeightList: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var pet: Pet
    
    @State private var selectedTimePeriod: TimePeriod = .lastSixMonthsPeriod
    @State private var showingAddWeightSheet: Bool = false
    
    private let lastSixMonths = Date.now - (86400 * 180)
    private let lastTwelveMonths = Date.now - (86400 * 365)
    
    private var selectedDateRange: ClosedRange<Date> {
        switch selectedTimePeriod {
        case .lastSixMonthsPeriod:
            return lastSixMonths ... .now
        case .lastTwelveMonthsPeriod:
            return lastTwelveMonths ... .now
        }
    }
    
    var scrollPositionStartString: String {
        pet.reverseSortedWeights.last!.date.formatted(
            .dateTime.month().day()
        )
    }
    
    var scrollPositionEndString: String {
        pet.reverseSortedWeights.first!.date.formatted(
            .dateTime.month().day().year()
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Picker(
                    "Time Period",
                    selection: $selectedTimePeriod.animation()
                ) {
                    ForEach(TimePeriod.allCases.reversed()) { period in
                        Text(period.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                if !pet.weights.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Average weight")
                        
                        Text(
                            String(
                                format: "%.2f \(Weight.units)",
                                pet.weights.averaging()
                            )
                        )
                        .font(.title)
                        .bold()
                        
                        Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                            .foregroundStyle(.secondary)
                        
                        WeightListChart(
                            weights: pet.filteringAndSortingWeights(
                                in: selectedDateRange
                            )
                        )
                        .frame(height: 240)
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                    .padding(.top, 2)
                }

                List {
                    Section("Weight List") {
                        ForEach(pet.reverseSortedWeights) { weight in
                            NavigationLink {
                                WeightDetail(pet: pet, weight: weight)
                            } label: {
                                WeightListRow(weight: weight)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("\(pet.name)'s weight list")
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled()
            .sheet(isPresented: $showingAddWeightSheet) {
                WeightDetail(pet: pet) 
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
                
                ToolbarItem {
                    Button { showingAddWeightSheet.toggle() } label: {
                        Label("Add weight", systemImage: "plus")
                    }
                }
                
                if !pet.weights.isEmpty {
                    ToolbarItem(placement: .status) {
                        Text("\(pet.weights.count) weights")
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    WeightList(pet: SampleData.shared.petWithChipID)
}
