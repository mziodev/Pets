//
//  PetCardAge.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct PetCardAge: View {
    let year: String?
    let month: String?
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(year ?? "")
                .font(.largeTitle.bold())
                .fontDesign(.serif)
            
            Text(month ?? "")
                .font(.callout.lowercaseSmallCaps())
                .foregroundStyle(.tint)
                .padding(.top, 12)
            
            Spacer()
        }
        .frame(height: 50)
    }
}

#Preview {
    PetCardAge(year: "2 years", month: "4 months")
}
