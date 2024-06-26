//
//  PetCardOnFamily.swift
//  Pets
//
//  Created by MZiO on 26/6/24.
//

import SwiftUI

struct PetCardOnFamily: View {
    let onFamilyYears: [String: String]

    
    var body: some View {
        HStack {
            Spacer()
            
            if let yearString = onFamilyYears["year"] {
                Text(yearString)
            }
            
            if let monthString = onFamilyYears["month"] {
                Text(monthString)
                    .padding(.leading, -5)
            }
            
            if let dayString = onFamilyYears["day"] {
                Text(dayString)
            }
            
            Text("on family")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.tint)
            
            Spacer()
        }
        .font(.callout)
    }
}


#Preview("Years and months") {
    PetCardOnFamily(onFamilyYears: SampleData.shared.petWithoutChipID.onFamilyYears)
}
