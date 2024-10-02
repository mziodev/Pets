//
//  PetsStore.swift
//  Pets
//
//  Created by MZiO on 2/9/24.
//

import StoreKit
import SwiftUI

struct PetsStoreView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var petsStoreManager: PetsStoreManager
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Subscribe to Pets Premium and get:")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        PetsStoreFeature(
                            feature: String(localized: "Unlimited pets.")
                        )
                        
                        PetsStoreFeature(
                            feature: String(localized: "Vaccine and Deworming Treatment notifications.")
                        )
                        
                        PetsStoreFeature(
                            feature: String(localized: "Weights, Vaccines and Deworming Treatment notes.")
                        )
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
                                    colors: [.petsSunset, .petsFulvous]
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
                
                VStack {
                    Button("Restore Purchase") {
                        Task {
                            do {
                                try await AppStore.sync()
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .font(.body.smallCaps())
                    
                    VStack(spacing: 10) {
                        Link(
                            "Privacy policy",
                            destination: URLs.privacyPolicyURL
                        )
                        
                        Link("Terms of use", destination: URLs.termsOfUseURL)
                    }
                    .padding(.top)
                    .font(.subheadline)
                }
                .padding(.vertical, 20)
            }
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

struct PetsStoreFeature: View {
    let feature: String
    
    var body: some View {
        HStack {
            Image(
                systemName: "checkmark.seal"
            )
            .symbolRenderingMode(.palette)
            .foregroundStyle(.petsFulvous, .accent)
            
            Text(feature)
        }
    }
}

#Preview {
    PetsStoreView()
        .environmentObject(PetsStoreManager())
}
