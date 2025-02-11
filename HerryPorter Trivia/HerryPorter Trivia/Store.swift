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
    @Published var bookStatus: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .active]
    @Published var products: [Product] = []
    private var productId = ["hp4", "hp5","hp6","hp7"]

    func loadProducts() async {
        do {
            products = try await Product.products(for: productId)
        }
        catch {
            print("Couldn't fetch products and Error: \(error) ")
        }
    }
}
