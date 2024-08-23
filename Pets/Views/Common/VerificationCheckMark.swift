//
//  VerifiedCheckMark.swift
//  Pets
//
//  Created by MZiO on 7/6/24.
//

import SwiftUI

struct VerificationCheckMark: View {
    let condition: Bool
    
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: "checkmark.circle")
                .foregroundStyle(condition ? .petsAccentBlue : .gray)
        }
    }
}


#Preview("Incorrect condition") {
    VerificationCheckMark(condition: false)
        .padding()
}

#Preview("Correct condition") {
    VerificationCheckMark(condition: true)
        .padding()
}
