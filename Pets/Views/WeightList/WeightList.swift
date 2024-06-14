//
//  WeightList.swift
//  Petee
//
//  Created by MZiO on 21/5/24.
//

/*
 TODO:
 Add current age on each weight??? for checking pet grow. Show age on each weight bar on chart
 */

import Charts
import SwiftData
import SwiftUI

struct WeightList: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var pet: Pet
    
    @State private var selectedTimePeriod: TimePeriod = .lastSixMonths
    @State private var showingAddWeightSheet: Bool = false
    
    private let lastSixMonthsRange = Date.now - (86400 * 180) ... Date.now
    private let lastTwelveMonthsRange = Date.now - (86400 * 365) ... Date.now
    
    
    // MARK: - computed properties
    private var selectedDateRange: ClosedRange<Date> {
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
        pet.reverseSortedWeights.last!.date.formatted(
            .dateTime.month().day()
        )
    }
    
    var scrollPositionEndString: String {
        pet.reverseSortedWeights.first!.date.formatted(
            .dateTime.month().day().year()
        )
    }
    
    
    // MARK: - body
    var body: some View {
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
            
            
            // MARK: - chart
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
                        weights: pet.filteringAndSortWeights(
                            in: selectedDateRange
                        )
                    )
                    .frame(height: 240)
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.top, 2)
            }
            
            
            // MARK: - weight list
            List {
                Section("Weight list") {
                    ForEach(pet.reverseSortedWeights) { weight in
                        WeightListRow(weight: weight)
                    }
                    .onDelete(perform: deleteWeights)
                }
            }
        }
        .navigationTitle("\(pet.name)'s weight list")
        .navigationBarTitleDisplayMode(.inline)
        
        
        // MARK: - add weight sheet
        .sheet(isPresented: $showingAddWeightSheet) {
            WeightDetail(pet: pet)
                .interactiveDismissDisabled()
        }
        
        
        //MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add weight") { showingAddWeightSheet.toggle() }
                    .bold()
            }
            
            if !pet.weights.isEmpty {
                ToolbarItem(placement: .topBarTrailing) { EditButton() }
            }
        }
    }
    
    
    
    // MARK: - functions
    private func deleteWeights(offsets: IndexSet) {
        offsets.forEach { modelContext.delete(pet.weights[$0]) }
    }
}


// MARK: - previews
#Preview {
    NavigationStack {
        WeightList(pet: SampleData.shared.petWithChipID)
    }
}
