//
//  ProfileViewModel.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/11/24.
//

import SwiftUI

@Observable
class ProfileViewModel {
    private var service: NetworkManager
    var error: String = ""
    var user: GitHubUser?
    
    init() {
        self.service = NetworkManager()
    }
    
    func getUser() async {
        
        do {
            user =  try await service.getUser()
            
        } catch GHError.invalidURL {
            print("ERROR: Invalid URL")
        } catch GHError.invalidResponse {
            print("ERROR: Invalid Response")
        } catch GHError.invalidData {
            print("ERROR: Invalid Data")
        } catch {
            print("ERROR FATAL: Invalid Data")
        }
    }
}
