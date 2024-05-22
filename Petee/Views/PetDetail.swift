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
    @State var isFormDisabled = true
    
    private let compliments = [
        "handsome", "beautiful", "lovely", "nice", "good-looking", "cute", "pretty"
    ]
    
    // MARK: - computed properties
//    private var weightFormatter: Formatter {
//        let formatter = NumberFormatter()
//        
//        formatter.numberStyle = .decimal
//        
//        return formatter
//    }
    
    var petInfo: String {
        "\(pet.name) is a \(pet.age) \(compliments.randomElement() ?? "") \(pet.sex.rawValue) \(pet.type.rawValue)"
    }
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 150)
                        .foregroundStyle(.black.opacity(0.1))
//                        .shadow(radius: 10, x: 3, y: 5)
                    
                    Image(systemName: "teddybear.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.secondary)
                }
                .padding(.top)
                
                if !isFormDisabled {
                    Button("Edit") {
                        // add pet foto
                    }
                }
            }
            
            Form {
                Section("Quick Info") {
                    Text(petInfo)
                        .lineLimit(2)
                }
                
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
                    .foregroundStyle(isFormDisabled ? .primary : Color.blue)
                    
                    DatePicker(
                        "On the family since",
                        selection: $onFamilySince,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    )
                    .foregroundStyle(isFormDisabled ? .primary : Color.blue)
                }
                .disabled(isFormDisabled)
                
                Section("Weight (Kg.)") {
                    NavigationLink{
                        WeightList(pet: pet)
                    } label: {
                        Text("\(pet.sortedWeights[0].value.formatted())")
                    }
                }
            }
        }
        .navigationTitle(pet.name)
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
            
//            ToolbarItem(placement: .status) {
//                Text(pet.age)
//                    .font(.caption)
//            }
        }
        .onAppear {
            breed = pet.breed
            birthday = pet.birthday
            onFamilySince = pet.onFamilySince
        }
    }
}

#Preview {
    NavigationStack {
        PetDetail(pet: SampleData.shared.pet)
    }
}
