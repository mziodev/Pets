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
        pet.unwrappedWeights.filteringAndSorting(
            in: selectedDateRange
        )
    }
    
    var scrollPositionStartString: String {
        pet.unwrappedWeights.reverseSortedByDate.last!.date.formatted(
            .dateTime.month().day()
        )
    }
    
    var scrollPositionEndString: String {
        pet.unwrappedWeights.reverseSortedByDate.first!.date.formatted(
            .dateTime.month().day().year()
        )
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
                            Text("Average weight")
                            
                            Text(
                                String(
                                    format: "%.2f %@",
                                    locale: Locale.current,
                                    selectedDateRangeWeights.averaging(),
                                    Format.weightUnits
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
                        Section("Weight List (\(Format.weightUnits))") {
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: dismissView)
                }
                
                ToolbarItem {
                    Button { showingAddWeightSheet.toggle() } label: {
                        Label("Add weight", systemImage: "plus")
                    }
                }
                
                if !pet.unwrappedWeights.isEmpty {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done", action: dismissView)
                    }
                    
                    ToolbarItem(placement: .status) {
                        Text("\(pet.unwrappedWeights.count) weights")
                            .font(.caption)
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
