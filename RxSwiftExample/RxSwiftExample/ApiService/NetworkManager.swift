//
//  NetworkManager.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 9.05.2022.
//
import Moya

class NetworkManager : INetworkManager {
    
    // Network manager'dan singleton oluşturduk ve interface'i implemente ettik.
    static let shared = NetworkManager()
    
    // Provider'larımızı initalize ettik.
    var userProvider: MoyaProvider<UserService>? = MoyaProvider<UserService>()
    
    // Metodları override ediyoruz ve request diye ilgili provider'ı, o provider'da hangi metodu kullanacağımızı belirtiyoruz ve completion ile dönüyoruz.
    func getAllUsers(completion: @escaping (Result<[User], APIError>) -> ()) {
        request(provider: userProvider, target: .getAllUsers, completion: completion)
    }
    
    func addUser(userRequest: UserRequest, completion: @escaping (Result<UserResponse, APIError>) -> ()) {
        request(provider: userProvider, target: .addUser(userRequest: userRequest), completion: completion)
    }
    
    func deleteUser(userRequest: UserRequest, completion: @escaping (Result<UserResponse, APIError>) -> ()) {
        request(provider: userProvider, target: .deleteUser(userRequest: userRequest), completion: completion)
    }
    
}

// Burada her istekte yaptığımız json decode ve success, error handle işlemlerini tek bir sefer yazıyoruz ve gelen parametrelere göre değişiyor.
private extension NetworkManager {
    private func request<T: Decodable, T1: TargetType>(provider: MoyaProvider<T1>?, target: T1, completion: @escaping (Result<T, APIError>) -> ()) {
        guard let provider = provider else {return}
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(APIError(response: response as! URLResponse)))
                }
            case let .failure(error):
                completion(.failure(error as! APIError))
            }
        }
    }
}
