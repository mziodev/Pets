//
//  FontTest.swift
//  Pets
//
//  Created by MZiO on 14/6/24.
//

import SwiftUI

struct FontTest: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Large Title")
                .font(.largeTitle)
            
            Text("Title")
                .font(.title)
            
            Text("Title 2")
                .font(.title2)
            
            Text("Title 3")
                .font(.title3)
            
            Text("Body (default)")
//                .font(.body)
            
            Text("Callout")
                .font(.callout)
            
            Text("Headline")
                .font(.headline)
            
            Text("Subheadline")
                .font(.subheadline)
            
            Text("Footnote")
                .font(.footnote)
            
            Text("Caption")
                .font(.caption)
            
            Text("Caption 2")
                .font(.caption2)
        }
    }
}

#Preview {
    FontTest()
}
