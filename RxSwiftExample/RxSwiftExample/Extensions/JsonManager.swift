//
//  Json.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 16.07.2022.
//

import Foundation

struct JsonManager {
    
    // JsonManager class'ı yazdık modelleri jsona çevirip jsondan modele çeviriyoruz.
    static let shared = JsonManager()
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    func toJson(_ model: User) -> Data? {
        do {
            let jsonData = try jsonEncoder.encode(model)
            return jsonData
        } catch {
            return nil
        }
    }
    
    func fromJson(_ data: Data?) -> User? {
        guard let data = data else { return nil }
        do {
            let user = try jsonDecoder.decode(User.self, from: data)
            return user
        } catch {
            return nil
        }
       
    }
}
