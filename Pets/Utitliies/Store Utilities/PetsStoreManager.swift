//
//  StoreManager.swift
//  Pets
//
//  Created by MZiO on 3/9/24.
//

import Foundation
import StoreKit

typealias PurchaseResult = Product.PurchaseResult

class PetsStoreManager: ObservableObject {
    @Published private(set) var products = [Product]()
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    let productIDs = [
        "dev.mzio.pets.premium",
        "dev.mzio.pets.premium.suscription"
    ]
    
    private var updates: Task<Void, Never>? = nil
    
    var isPremiumUnlocked: Bool { !purchasedProductIDs.isEmpty }
    
    init() {
        Task { [weak self] in
            await self?.loadProducts()
        }
        
        updates = observeTransactionsUpdates()
    }
    
    deinit {
        updates?.cancel()
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            try await handlePurchase(from: result)
        } catch {
            print("Error purchasing product: \(error)")
        }
    }
    
    @MainActor
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                return
            }
            
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
    }
}

private extension PetsStoreManager {
    @MainActor
    func loadProducts() async {
        do {
            products = try await Product.products(
                for: ["dev.mzio.pets.premium.suscription"]
            ).sorted { $0.price < $1.price }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handlePurchase(from result: PurchaseResult) async throws {
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            
            // Verification was ok, update UI
            print("Purchase done")
            
            await transaction.finish()
            await updatePurchasedProducts()
        case .pending:
            // 'Ask to Buy' or 'Strong Customer Authentication' (SCA)
            print("Purchase pending to complete some action before ending")
        case .userCancelled:
            print("User hit Cancel button before the transaction started")
        @unknown default:
            print("Unknown error")
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            print("Verification of the user failed") // Jailbroken phone?
            throw PetsStoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    func observeTransactionsUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                await self.updatePurchasedProducts()
            }
        }
    }
}
