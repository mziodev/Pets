//
//  PetDataCardView.swift
//  Pets
//
//  Created by MZiO on 27/9/24.
//

import SwiftUI

struct PetCardSummaryView: View {
    
    let pet: Pet
    let summarySource: PetCardSummarySource
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(summarySource.localizedName)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.accent)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
            
            Group {
                if summarySource == .weights {
                    WeightDataView(
                        currentWeight: pet.unwrappedWeights.currentWeight
                    )
                } else if summarySource == .vaccines {
                    VaccineDataView(
                        nextVaccineToExpire: pet.unwrappedVaccines.nextToExpire
                    )
                } else if summarySource == .dewormings {
                    DewormingDataView(
                        nextDewormingToExpire: pet.dewormingTreatments?.nextToExpire
                    )
                }
            }
            .frame(height: 80)
            .padding(.horizontal)
            .padding(.vertical, 5)
            
        }
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    PetCardSummaryView(
        pet: SampleData.shared.petWithChipID,
        summarySource: .weights
    )
}

struct WeightDataView: View {
    
    let currentWeight: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Last")
                .font(.caption.smallCaps())
            
            Spacer()
            
            if currentWeight.isZero {
                Text("No data yet.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            } else {
                HStack(alignment: .bottom, spacing: 0) {
                    Text(
                        currentWeight as NSNumber,
                        formatter: Weight.decimalFormatter(
                            fractionDigits: 3
                        )
                    )
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundStyle(.accent)
                    
                    Text(Weight.units)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
    }
}

struct VaccineDataView: View {
    
    let nextVaccineToExpire: Vaccine?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Next to Expire")
                .font(.caption.smallCaps())
            
            if let lastActive = nextVaccineToExpire {
                Text(lastActive.name)
                    .font(.headline)
                
                VStack {
                    if lastActive.activeDays > 0 {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(lastActive.activeDays.formatted())
                                .font(.largeTitle)
                                .bold()
                                .fontDesign(.serif)
                                .foregroundStyle(lastActive.activeDaysColor)
                            
                            Text("More days")
                                .font(.caption2.smallCaps())
                                .foregroundStyle(.secondary)
                        }
                    } else {
                        Text("Last day")
                            .font(.caption2.smallCaps())
                            .foregroundStyle(.red)
                    }
                }
                .frame(maxWidth: .infinity)
            } else {
                Spacer()
                
                Text("No data yet.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
    }
}

struct DewormingDataView: View {
    
    let nextDewormingToExpire: DewormingTreatment?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Next to Expire")
                .font(.caption.smallCaps())
            
            if let lastActiveTreatment = nextDewormingToExpire {
                Text(lastActiveTreatment.name)
                    .font(.callout)
                    .bold()
                
                VStack {
                    if lastActiveTreatment.activeDays > 0 {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\(lastActiveTreatment.activeDays)")
                                .font(.largeTitle)
                                .bold()
                                .fontDesign(.serif)
                                .foregroundStyle(
                                    lastActiveTreatment.activeDaysColor
                                )
                            
                            Text("More days")
                                .font(.caption.smallCaps())
                                .foregroundStyle(.secondary)
                        }
                    } else {
                        Text("Last day")
                            .font(.caption.smallCaps())
                            .foregroundStyle(.red)
                    }
                }
                .frame(maxWidth: .infinity)
            } else {
                Spacer()
                
                Text("No data yet.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
    }
}
