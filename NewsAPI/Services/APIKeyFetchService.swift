//
//  APIKeyFetchService.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

final class APIKeyFetchService {
    private enum Constants {
        enum APIKeyErrors {
            static let apiKeyFetchError: String = "Fail when trying get API key"
        }
    }
    
    static private let ref = Database.database().reference()
    
    static func getAPIKeyFromBackend() {
        ref.child("APIKey").getData { error, snapshot in
            guard let key = snapshot?.value as? String else { return }
            KeyChainService.setKeyToKeychain(key)
        }
    }
}
