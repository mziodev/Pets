//
//  VerifiedCheckMark.swift
//  Pets
//
//  Created by MZiO on 7/6/24.
//

import SwiftUI

struct VerifiedCheckMark: View {
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
    VerifiedCheckMark(condition: false)
        .padding()
}

#Preview("Correct condition") {
    VerifiedCheckMark(condition: true)
        .padding()
}
