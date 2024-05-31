//
//  AddMenu.swift
//  Pets
//
//  Created by MZiO on 27/5/24.
//

import SwiftUI

struct AddMenu: View {
    var body: some View {
        Menu {
            Button {
                // add weight code
            } label: {
                Label("Weight", systemImage: "scalemass")
            }
            
            Button {
                // add vaccination code
            } label: {
                Label("Vaccine", systemImage: "syringe")
            }
            
            Button {
                // add deworming pill code
            } label: {
                Label("De-worming pill", systemImage: "pill")
            }
            
            Button {
                // add vet appointment code
            } label: {
                Label("Vet appointment", systemImage: "cross")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        .accessibilityLabel("Add menu")
    }
}

#Preview {
    AddMenu()
}
