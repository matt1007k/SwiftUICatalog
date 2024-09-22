//
//  NetworkManager2.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/21/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

final class APIManager {

    /*
     Error: throw
     response: return
     */
    func request<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

}

@Observable class ProductViewModel {

    var products: [Product] = []
    private let manager = APIManager()

    func fetchProducts() async {
        do {
            products = try await manager.request(url: "https://fakestoreapi.com/products")
            print(products)
        }catch {
            print("Fetch Product error:", error)
        }
    }
}

struct Product: Decodable, Identifiable {
    let id: Int
    let title, description, category, image: String
    let price: Double
    let rating: Rate

    static var dummy: Product {
        return Product(id: 1,
                       title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                       description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                       category: "men's clothing",
                       image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                       price: 109.95,
                       rating: Rate(rate: 3.9,
                                    count: 120))
    }
}

struct Rate: Decodable {
    let rate: Double
    let count: Int
}
