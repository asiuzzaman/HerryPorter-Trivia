//
//  Store.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 10/2/25.
//

import Foundation
import StoreKit



enum BookStatus {
    case active
    case inactive
    case locked
}

@MainActor
class Store: ObservableObject {
    @Published var bookStatus: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]
    @Published var products: [Product] = []
    private var productId = ["hp4", "hp5","hp6","hp7"]
    @Published var purchasedIDs = Set<String>()

    private var updates: Task<Void, Never>? = nil
    init() {
        updates = watchForUpdates()
    }

    func loadProducts() async {
        do {
            products = try await Product.products(for: productId)
        }
        catch {
            print("Couldn't fetch products and Error: \(error) ")
        }
    }

    func purchase(product: Product) async {
        do {
            let result = try await product.purchase()

            switch result {

            case .success(let verificationResult):
                switch verificationResult {

                case .unverified(let signType, let verificationError):
                    print("Error on verification: \(verificationError), \(signType)")
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                    print( "Purchase successful")
                }
            case .userCancelled:
                break
            case .pending:
                break
            @unknown default:
                print("There is an unknown error")
            }
        }
        catch {
            print("Couldn't purchase product and Error: \(error) ")
        }
    }

    private func checkedPurchesed() async {
        for product in products {
            guard let state = await product.currentEntitlement else { return }

            switch state {
                case .unverified(let signedType, let verificationError):
                print("Error on verification: \(verificationError), \(signedType)")
            case .verified(let signedType):
                if signedType.revocationDate == nil {
                    purchasedIDs.insert(signedType.productID)
                } else {
                    purchasedIDs.remove(signedType.productID)
                }

                print( "Purchase successful")
            @unknown default:
                print("There is an unknown error")
            }

        }
    }

    private func watchForUpdates() -> Task<Void, Never> {

        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkedPurchesed()
            }
        }
    }
}
