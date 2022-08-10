//
//  UserAssembly.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.06.2022.
//

import Foundation
import Swinject

final class UserAssembly : Assembly {
     
    func assemble(container: Container) {
        getUserServiceAssemble(container: container)
        getUserViewModelAssemble(container: container)
    }
    
    // UserAssembly'de User screen ile ilgili dependency'leri ekledik ve protocol'lerin tipini tanımladık.
    // Burada inObjectScope diyerek singleton objeleri tanımlıyoruz.
    private func getUserServiceAssemble(container: Container) {
        container.register(INetworkManager.self) { _ in
            let networkManager = NetworkManager.shared
            return networkManager
        }.inObjectScope(.container)
    }
    
    private func getUserViewModelAssemble(container: Container) {
        
        container.register(IUserViewModel.self) { resolver in
            let networkManager = resolver.resolve(INetworkManager.self)
            if let networkManager = networkManager {
                return UserViewModel(networkManager: networkManager)
            }
         //   return UserViewModel(networkManager: NetworkManager.self)
          /*  if let networkManager = networkManager {
                return UserViewModel(networkManager: networkManager)
            }*/
            return UserViewModel(networkManager: NetworkManager())
        }
       
        
      /*  container.register(IUserViewModel.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManager.self) else {
                fatalError("UseCaseProviderProtocol dependency could not be resolved")
            }
            return UserViewModel(networkManager: networkManager)
        }.inObjectScope(.container)*/
        
        
    }
    
}
