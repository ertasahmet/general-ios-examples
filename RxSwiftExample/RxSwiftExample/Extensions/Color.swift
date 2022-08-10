//
//  Color.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 15.07.2022.
//

import UIKit

// Color için bir extension yazdık ve temaları tanıttık.
extension UIColor {
    
    static let theme = ColorTheme()
    static let otherTheme = SecondColorTheme()
    
}

// Temaların içinde de colorları tanımladık. UI kısmında UIColor.theme.AccentColor şeklinde erişebiliyoruz. Aynı işlem fontlar için de yapılabilir. Image'lar için de yapılabilir.
struct ColorTheme {
    
    let AccentColor = UIColor(named: "AccentColor")
    let BackgroundColor = UIColor(named: "BackgroundColor")
    let RedColor = UIColor(named: "RedColor")
}


struct SecondColorTheme {
    
    let AccentColor = UIColor(named: "AccentColor")
    let BackgroundColor = UIColor(named: "BackgroundColor")
    let RedColor = UIColor(named: "BackgroundColor")
}
