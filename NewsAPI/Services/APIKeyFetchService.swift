//
//  APIKeyFetchService.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Foundation
import KeychainSwift
import FirebaseDatabase
import FirebaseDatabaseSwift

final class APIKeyFetchService {
    private enum Constants {
        enum APIKeyErrors {
            static let apiKeyFetchError: String = "Fail when trying get API key"
        }
    }
    
    static private let ref = Database.database().reference()
    static private let keychain = KeychainSwift()
    
    static func getAPIKeyFromBackend() {
        ref.child("APIKey").getData { error, snapshot in
            guard let key = snapshot?.value as? String else { return }
            setKeyToKeychain(key)
        }
    }
    
    static private func setKeyToKeychain(_ key: String) {
        if let storedKey = keychain.get("APIKey"), key == storedKey {
            print("Key is already saved")
        } else {
            keychain.set(key, forKey: "APIKey")
        }
    }
}
