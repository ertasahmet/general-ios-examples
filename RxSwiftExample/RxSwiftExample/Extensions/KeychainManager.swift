//
//  KeychainManager.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 16.07.2022.
//

import Foundation
import KeychainSwift

struct KeychainManager {
    
    // Burada KeychainSwift kütüphanesi sayesinde hassas bilgileri Apple'ın keychainine kaydediyoruz. Keyleri enum şeklinde tutuyoruz.
    static let shared = KeychainManager()
    private let keychain = KeychainSwift()
    
    func setUser(_ user: User) {
        let jsonData = JsonManager.shared.toJson(user)
        if let jsonData = jsonData {
            keychain.set(jsonData, forKey: KeychainKeys.user.rawValue)
        }
        
    }
    
    func getUser() -> User? {
        let jsonData = keychain.getData(KeychainKeys.user.rawValue)
        let user = JsonManager.shared.fromJson(jsonData)
        guard let user = user else { return nil }
        return user
    }
}


enum KeychainKeys : String {
    case user
    case dish
}
