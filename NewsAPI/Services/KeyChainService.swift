//
//  KeyChainService.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 19.10.2023.
//

import Foundation
import KeychainSwift

final class KeyChainService {
    static private let keychain = KeychainSwift()
    
    static func setKeyToKeychain(_ key: String) {
        if let storedKey = keychain.get("APIKey"), key == storedKey {
            print("Key is already saved")
        } else {
            keychain.set(key, forKey: "APIKey")
        }
    }
    
    static func getAPIKey() -> String {
        guard let key: String = keychain.get("APIKey") else { return "Keychain doesn`t contain key" }
        
        return key
    }
}
