//
//  Dish.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 14.07.2022.
//

import Foundation

struct Dish {
    let title: String
    let desc: String
    let calory: String
    let image: String
}

let dishes: [Dish] = [
    Dish(title: "Pizza", desc: "Pizza is the one", calory: "560", image: "https://static.wixstatic.com/media/693edc_e8fb2ea7cbb8487ca1c4d0700355d17f~mv2.jpg/v1/fill/w_640,h_600,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/693edc_e8fb2ea7cbb8487ca1c4d0700355d17f~mv2.jpg"),
    Dish(title: "Kebab", desc: "Turkish kebab", calory: "871", image: "https://www.travelvui.com/wp-content/uploads/2017/01/Adana-Kebab-istanbul-860x645.jpg"),
    Dish(title: "Grilled Fish", desc: "Fish is awesome", calory: "115", image: "https://i.pinimg.com/originals/c1/9e/5f/c19e5fc6f50468c78f4384395b4f2b68.jpg"),
    Dish(title: "Spaghetti", desc: "Spaghetti is important for me", calory: "1982", image: "https://veganwithgusto.com/wp-content/uploads/2021/05/speedy-spaghetti-arrabbiata-featured-e1649949762421.jpg")
    
]
