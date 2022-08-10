//
//  Food.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 5.05.2022.
//

import Foundation

struct Food {
    let name: String
    let image: String
    let type: String
    
    init(name: String, image: String, type: String) {
        self.name = name
        self.image = image
        self.type = type
    }
}
