//
//  VerifiedCheckMark.swift
//  Pets
//
//  Created by MZiO on 7/6/24.
//

import SwiftUI

struct PetDetailCheckMark: View {
    let condition: Bool
    
    
    // MARK: - body
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: "checkmark.circle")
                .foregroundStyle(condition ? .green : .gray)
        }
    }
}


// MARK: - previews
#Preview("Incorrect condition") {
    PetDetailCheckMark(condition: false)
        .padding()
}

#Preview("Correct condition") {
    PetDetailCheckMark(condition: true)
        .padding()
}
