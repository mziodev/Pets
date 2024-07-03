//
//  PetCardAge.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardAge: View {
    let pet: Pet
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                
                Text("Age")
                    .font(.callout.lowercaseSmallCaps())
                    .foregroundStyle(.tint)
                
                if let yearString = pet.age["year"] {
                    Text(yearString)
                        .font(.title.bold())
                        .fontDesign(.serif)
                }
                
                if let monthString = pet.age["month"] {
                    Text(monthString)
                        .font(pet.age["year"] == nil ? .title.bold() : .body)
                        .fontDesign(.serif)
                        .foregroundStyle(.petsAccentBlue)
                        .padding(.top, pet.age["year"] == nil ? 0 : 7)
                }
                
                if let dayString = pet.age["day"] {
                    Text(dayString)
                        .font(.largeTitle.bold())
                        .fontDesign(.serif)
                }
                
                Spacer()
            }
            
            PetCardOnFamily(onFamilyYears: pet.onFamilyYears, adopted: pet.isAdopted)
        }
    }
}


#Preview("Years and months") {
    PetCardAge(pet: SampleData.shared.petWithChipID)
}

#Preview("Just days") {
    PetCardAge(pet: SampleData.shared.petWithoutSpecies)
}
