//
//  User.swift
//  SwiftAnimation
//
//  Created by Ahmet Ertas on 22.06.2022.
//

import Foundation

public struct User {
   
    var id: Int
    var name: String
    var gender: Bool
    
    internal init(id: Int, name: String, gender: Bool) {
        self.id = id
        self.name = name
        self.gender = gender
    }
    
}
