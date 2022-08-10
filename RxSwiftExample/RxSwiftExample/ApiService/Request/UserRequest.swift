//
//  UserRequest.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 9.05.2022.
//

import Foundation

// Request modellerini hazırlıyoruz.
struct UserRequest : Decodable {
    var id: Int
    var name: String
}
