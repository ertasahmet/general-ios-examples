//
//  UserResponse.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 9.05.2022.
//

import Foundation

// Response modellerini hazırlıyoruz.
struct UserResponse: Decodable {
    let id: Int
    let name: String
}
