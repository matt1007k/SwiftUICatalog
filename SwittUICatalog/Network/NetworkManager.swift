//
//  NetworkManager.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/11/24.
//

import SwiftUI

class NetworkManager {
    func getUser() async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/matt1007k"
        
        guard let url  = URL(string: endpoint) else { throw GHError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // A key decoding strategy that converts snake-case keys to camel-case keys.
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}


enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
