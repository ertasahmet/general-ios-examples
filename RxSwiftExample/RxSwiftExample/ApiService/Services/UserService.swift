//
//  UserService.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 8.05.2022.
//

import Foundation
import Moya

// Moya'yı import ediyoruz ve UserService isminde bir enum oluşturduk ve api'ye atacağımız istekler için case oluşturduk. Parametre alıyorlarsa parametre ekledik.
enum UserService {
    case addUser(userRequest: UserRequest)
    case getAllUsers
    case updateUser(userRequest: UserRequest)
    case deleteUser(userRequest: UserRequest)
}

// Moya'nın TargetType interface'ini implemente ettik ve metodları override ediyoruz.
extension UserService: TargetType {
    
    // Buraya baseUrl'i yazıyoruz.
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    // Metodlar için path veriyoruz.
    var path: String {
        switch self {
        case .getAllUsers, .addUser(_):
            return "users"
            
        case .updateUser(let user), .deleteUser(let user):
            return "users/\(user.id)"
            
        }
    }
    
    // İstek atacağımız parametreleri sampleData ile örnek veriyoruz.
    var sampleData: Data {
        switch self {
        case .addUser(let user):
            return "{'name': '\(user.name)'}".data(using: .utf8)!
            
        case .getAllUsers:
            return Data()
            
        case .updateUser(let user):
            return "{'id': '\(user.id)', 'name': '\(user.name)'}".data(using: .utf8)!
            
        case .deleteUser(let user):
            return "{'id': '\(user.id)'}".data(using: .utf8)!
        }
    }
    
    // Hangi istek hangi metod ile atılacak onu belirtiyoruz. (get, post vs)
    var method: Moya.Method {
        switch self {
        case .addUser(_):
            return .post
            
        case .getAllUsers:
            return .get
            
        case .updateUser(_):
            return .put
            
        case .deleteUser(_):
            return .delete
        }
    }
    
    // İsteklere parametre ekleyecek miyiz onu belirtiyoruz.
    var task: Task {
        switch self {
        case .getAllUsers, .deleteUser(_):
            return .requestPlain
            
        case .updateUser(let user), .addUser(let user):
            return .requestParameters(parameters: ["name": user.name], encoding: JSONEncoding.default)
        }
    }
    
    // Header'ları belirtiyoruz. İsteklere özel header'lar da belirtebiliriz.
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
