//
//  Resolver.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.06.2022.
//

import Foundation
import Swinject

final class Resolver {
  static let shared = Resolver()
  
  private var container = buildContainer()
  
  func resolve<T>(_ type: T.Type) -> T {
    container.resolve(T.self)!
  }
}

fileprivate func buildContainer() -> Container {
  let container = Container()
  
  container.register(INetworkManager.self) { _ in
      return NetworkManager.shared
  }
  .inObjectScope(.container)
    
    container.register(UserController.self) { r in
        let controller = UserController.instantiate()
        controller.viewModel = r.resolve(UserViewModel.self)!
        return controller
    }
  
 /* container.register(ProductService.self) { _ in
    return ProductRepository()
  }
  .inObjectScope(.container)
  
  container.register(LocalBasketService.self) { _ in
    return LocalBasketRepository()
  }
  .inObjectScope(.container)
  
  container.register(AccountService.self) { _ in
    return AccountRepository()
  }
  .inObjectScope(.container)*/
  
  return container
}
