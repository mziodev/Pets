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
    
    @State var breed = ""
    @State var birthday = Date.now
    @State var onFamilySince = Date.now
    @State var image: String?
    @State var weight: Double = 0
    
    @State var isFormDisabled = true
    
    private var weightFormatter: Formatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        return formatter
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 200)
                    .foregroundStyle(.white)
                    .shadow(radius: 10, x: 3, y: 5)
                
                Image(systemName: "teddybear.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.secondary)
                
                Button {
                    // add pet foto
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .bold()
                }
                .offset(x: 40, y: 55)
            }
            .padding()
            
            Form {
                Section("Breed") {
                    TextField("Breed", text: $breed)
                }
                
                Section("Dates") {
                    DatePicker(
                        "Born on",
                        selection: $birthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        "On the family since",
                        selection: $onFamilySince,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                }
                
                Section("Weight (Kg.)") {
                    TextField("\(pet.name) weight", value: $weight, formatter: weightFormatter)
                }
            }
            .disabled(isFormDisabled)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isFormDisabled ? "Edit" : "Done") {
                        withAnimation {
                            isFormDisabled.toggle()
                        }
                        
                        if !isFormDisabled {
                            
                            
                            // save pet data
                        }
                    }
                }
            }
        }
        .navigationTitle(pet.name)
        .onAppear {
            breed = pet.breed
            birthday = pet.birthday
            onFamilySince = pet.onFamilySince
            weight = pet.weight
        }
    }
}

#Preview {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
    }
}
