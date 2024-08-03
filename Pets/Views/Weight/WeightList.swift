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
        pet.filteringAndSortingWeights(in: selectedDateRange)
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
                if !pet.weights.isEmpty {
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
                            Text("Average weight")
                            
                            Text(
                                String(
                                    format: "%.2f %@",
                                    locale: Locale.current,
                                    selectedDateRangeWeights.averaging(),
                                    Weight.units
                                )
                            )
                            .font(.largeTitle)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundStyle(.accent)
                            
                            Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
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
                            ForEach(pet.reverseSortedWeights) { weight in
                                NavigationLink {
                                    WeightDetail(pet: pet, weight: weight)
                                } label: {
                                    WeightListRow(weight: weight)
                                }
                            }
                        }
                    }
                } else {
                    WeightListNoWeight()
                }
            }
            .navigationTitle("\(pet.name)'s weight list")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddWeightSheet) {
                WeightDetail(pet: pet, isNew: true)
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
    WeightList(pet: SampleData.shared.petWithoutChipID)
}
