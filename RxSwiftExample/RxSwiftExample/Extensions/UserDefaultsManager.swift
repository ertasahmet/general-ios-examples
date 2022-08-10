//
//  UserDefaultsManager.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 1.07.2022.
//

import Foundation

struct UserDefaultsManager {
    
    // User Defaults veri kaydetmek için bir manager sınıfı açtık.
    static var shared = UserDefaultsManager()
    
    private init() { }
    
    // Kaydedeceğimiz keyler için enum oluşturduk.
    private enum UserDefaultsKeys: String {
        case switchIsOn
        case signedInUser
    }
    
    // Bool değişken için get ve set olarak tanımladık.
    // UserDefaultsManager.shared.switchIsOn = true -- Örnek kullanımı böyle
    var switchIsOn: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKeys.switchIsOn.rawValue)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.switchIsOn.rawValue)
        }
    }
    
    // Giriş yapan kullanıcıyı bu şekilde kaydediyoruz.
    var signedInUser: User? {
        get {
            if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.signedInUser.rawValue) as? Data {
                let user = try? JSONDecoder().decode(User.self, from: data)
                return user
            }
            return nil
        }
        
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.signedInUser.rawValue)
            } else {
                let data = try? JSONEncoder().encode(newValue)
                UserDefaults.standard.setValue(data, forKey: UserDefaultsKeys.signedInUser.rawValue)
            }
        }
    }
    
}
