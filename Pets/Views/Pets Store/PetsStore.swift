//
//  PetsStore.swift
//  Pets
//
//  Created by MZiO on 2/9/24.
//

import StoreKit
import SwiftUI

struct PetsStore: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    private let premiumFeatures = """
    Buy Premium and get:
    
    ✅ Unlimited pets.
    ✅ Vaccine and Deworming Treatment notifications.
    ✅ Weights, Vaccines and Deworming Treatment notes.
    """
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Buy Premium and get:")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "checkmark.seal")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.petsAccentRed, .petsAccentBlue)
                            
                            Text("Unlimited pets.")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.seal")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.petsAccentRed, .petsAccentBlue)
                            
                            Text("Vaccine and Deworming Treatment notifications.")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark.seal")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.petsAccentRed, .petsAccentBlue)
                            
                            Text("Weights, Vaccines and Deworming Treatment notes.")
                        }
                    }
                    .padding(.top)
                }
                .padding()
                
                if let product = petsStoreManager.products.first {
                    ProductView(id: product.id) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 90))
                            .foregroundStyle(
                                Gradient(
                                    colors: [
                                        .petsAccentRed,
                                        .petsAccentBlue
                                    ]
                                )
                            )
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 50)
                    .background(
                        .background.secondary,
                        in: .rect(cornerRadius: 20)
                    )
                    .productViewStyle(.large)
                }
                
                Spacer()
                
                Button("Restore Purchases") {
                    Task {
                        do {
                            try await AppStore.sync()
                        } catch {
                            print(error)
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding()
            .navigationTitle("Pets Store")
            .onInAppPurchaseCompletion { product, result in
                await petsStoreManager.purchase(product)
                dismissView() 
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ok", action: dismissView)
                }
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
}

#Preview {
    PetsStore()
        .environmentObject(PetsStoreManager())
}
