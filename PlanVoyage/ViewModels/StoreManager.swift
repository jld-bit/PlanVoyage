import Foundation
import StoreKit

@MainActor
final class StoreManager: ObservableObject {
    @Published var isPremium = false

    private let productIDs = ["planvoyage.premium.monthly"]

    func refreshEntitlements() async {
        for await verification in Transaction.currentEntitlements {
            if case .verified(let transaction) = verification, productIDs.contains(transaction.productID) {
                isPremium = true
                return
            }
        }
        isPremium = false
    }

    func purchasePremium() async throws {
        let products = try await Product.products(for: productIDs)
        guard let product = products.first else { return }
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            if case .verified(let transaction) = verification {
                isPremium = true
                await transaction.finish()
            }
        default:
            break
        }
    }
}
