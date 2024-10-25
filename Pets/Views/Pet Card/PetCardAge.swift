//
//  PetCardAge.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardAge: View {
    let age: [String: String]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                
                Text("Age")
                    .font(.callout.lowercaseSmallCaps())
                    .foregroundStyle(.tint)
                
                if let yearString = age["year"] {
                    Text(yearString)
                        .font(.title.bold())
                        .fontDesign(.serif)
                }
                
                if let monthString = age["month"] {
                    Text(monthString)
                        .font(age["year"] == nil ? .title.bold() : .body)
                        .fontDesign(.serif)
                        .foregroundStyle(.accent)
                        .padding(.top, age["year"] == nil ? 0 : 7)
                }
                
                if let dayString = age["day"] {
                    Text(dayString)
                        .font(.largeTitle.bold())
                        .fontDesign(.serif)
                }
                
                Spacer()
            } 
        }
    }
}

#Preview("Years and months") {
    PetCardAge(age: SampleData.shared.petWithChipID.age)
}

#Preview("Just days") {
    PetCardAge(age: SampleData.shared.petWithoutSpecies.age)
}
