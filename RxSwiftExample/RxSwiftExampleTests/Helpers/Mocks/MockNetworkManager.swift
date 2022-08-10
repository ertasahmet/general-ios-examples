//
//  MockNetworkManager.swift
//  RxSwiftExampleTests
//
//  Created by Ahmet Ertas on 1.07.2022.
//

import Foundation
import Moya
@testable import RxSwiftExample

class MockNetworkManager: INetworkManager {
    
    var userProvider: MoyaProvider<UserService>?
    var allUsersResponse: Result<[User], APIError>?
    var userResponse: Result<UserResponse, APIError>?
    
    func getAllUsers(completion: @escaping (Result<[User], APIError>) -> ()) {
        completion(allUsersResponse!)
    }
    
    func addUser(userRequest: UserRequest, completion: @escaping (Result<UserResponse, APIError>) -> ()) {
        completion(userResponse!)
    }
    
    func deleteUser(userRequest: UserRequest, completion: @escaping (Result<UserResponse, APIError>) -> ()) {
        completion(userResponse!)
    }
    
    
}
