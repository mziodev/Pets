//
//  PetDetail.swift
//  Petee
//
//  Created by MZiO on 20/5/24.
//

import SwiftData
import SwiftUI

struct PetDetail: View {
    @State var pet: Pet
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 200)
                    .foregroundStyle(.white)
                    .shadow(radius: 10, x: 3, y: 5)
                
                Image(systemName: "teddybear.fill")
                    .font(.system(size: 100))
            }
            .padding()
            
            VStack(alignment: .leading,spacing: 10) {
                Text(pet.breed)
                    .font(.headline)
                
                Text("Born on \(pet.birthday.formatted(date: .complete, time: .omitted))")
                
                Text("Part of the family since \(pet.onFamilySince.formatted(date: .complete, time: .omitted))")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle(pet.name)
    }
}

#Preview {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
    }
}
