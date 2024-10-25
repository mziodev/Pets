//
//  PetCardOnFamily.swift
//  Pets
//
//  Created by MZiO on 26/6/24.
//

import SwiftUI

struct PetCardOnFamily: View {
    let onFamilyYears: [String: String]
    let adopted: Bool

    var body: some View {
        HStack {
            Spacer()
            
            HStack(spacing: 5) {
                if let yearString = onFamilyYears["year"] {
                    Text(yearString)
                }
                
                if let monthString = onFamilyYears["month"] {
                    Text(monthString)
                }
                
                if let dayString = onFamilyYears["day"] {
                    Text(dayString)
                }
            }
            .fontDesign(.serif)
            
            Text(adopted ? "since adopted" : "on Family")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.accent)
            
            Spacer()
        }
    }
}


#Preview("Not adopted") {
    PetCardOnFamily(
        onFamilyYears: SampleData.shared.petWithoutChipID.onFamilyYears,
        adopted: false
    )
}

#Preview("Adopted") {
    PetCardOnFamily(
        onFamilyYears: SampleData.shared.petWithoutChipID.onFamilyYears,
        adopted: true
    )
}
