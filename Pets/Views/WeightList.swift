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
    
    @State var pet: Pet
    
    @State private var selectedTimePeriod: TimePeriod = .lastSixMonths
    @State private var showingAddWeightSheet: Bool = false
    
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
                        Weight.getMeasuredValue(
                            from: getAverageWeight(in: pet.weights)
                        ),
                        format: formatStyle
                    )
                    .font(.title)
                    .bold()
                    
                    Text("\(scrollPositionStartString) – \(scrollPositionEndString)")
                        .foregroundStyle(.secondary)
                    
                    PetWeightChart(weights: pet.getSortedWeights(in: selectedRange))
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
                        HStack {
                            Text(
                                weight.date.formatted(date: .complete, time: .omitted)
                            )
                            
                            Spacer()
                            
                            Text(Weight.getMeasuredValue(from: weight.value), format: formatStyle)
                                .bold()
                        }
                    }
                    .onDelete(perform: deleteWeights)
                }
            }
            .navigationTitle("\(pet.name) weight list")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: pet.weights) {
            if pet.weights.isEmpty { dismiss() }
        }
        .sheet(isPresented: $showingAddWeightSheet) {
            AddWeight(pet: pet)
        }
        
        
        //MARK: - toolbar
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAddWeightSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add weight")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
    
    
    // MARK: - functions
    private func getAverageWeight(in weights: [Weight]) -> Double {
        var totalWeight: Double = 0
        
        for weight in weights {
            totalWeight += weight.value
        }
        
        return totalWeight / Double(weights.count)
    }
    
    private func deleteWeights(offsets: IndexSet) {
        withAnimation {
            pet.weights.remove(atOffsets: offsets)
        }
    }
}


// MARK: - previews
#Preview("Light mode") {
    NavigationStack {
        WeightList(pet: SampleData.shared.petWithChipID)
    }
}
