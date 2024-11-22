//
//  VaccineCard.swift
//  Pets
//
//  Created by MZiO on 30/9/24.
//

import SwiftUI

struct VaccineCard: View {
    let pet: Pet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Vaccines")
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.accent)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Next to Expire")
                    .font(.caption.smallCaps())
                
                if let lastActive = pet.unwrappedVaccines.nextToExpire {
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
                    
                    VStack {
                        Text("No data yet.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
            }
            .frame(height: 80)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .background(.thickMaterial)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    VaccineCard(pet: SampleData.shared.petWithExpiredVaccines).padding()
}
