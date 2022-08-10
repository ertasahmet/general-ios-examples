//
//  Inject.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.06.2022.
//

import Foundation

@propertyWrapper
struct Inject<T> {
  let wrappedValue: T
  
  init() {
    // resolve the interface to an implementation
    self.wrappedValue = Resolver.shared.resolve(T.self)
  }
}
