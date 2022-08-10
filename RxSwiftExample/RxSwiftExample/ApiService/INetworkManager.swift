//
//  INetworkManager.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 9.05.2022.
//

import Foundation
import Moya

// Bir network manager interface'i oluşturduk ve buraya moya ile oluşturduğumuz provider'ları tanımlıyoruz ve istek atacağımız metodları belirtiyoruz.
protocol INetworkManager {
    var userProvider: MoyaProvider<UserService>? { get }
    
    func getAllUsers(completion: @escaping (Result<[User], APIError>) -> ())
    func addUser(userRequest: UserRequest, completion: @escaping (Result<UserResponse, APIError>) -> ())
    func deleteUser(userRequest: UserRequest, completion: @escaping (Result<UserResponse, APIError>) -> ())
}
