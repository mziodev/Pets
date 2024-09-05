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
    · Unlimited pets
    · Notifications
    · Notes
    """
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Go premium and get unlimited pets, deworming treatment and vaccine notifications, and notes.")
                        .font(.title3)
                }
                .padding(.top, 30)
                .padding(.bottom, 10)
                
                if let product = petsStoreManager.products.first {
                    ProductView(id: product.id) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 90))
                            .foregroundStyle(.petsAccentBlue)
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
