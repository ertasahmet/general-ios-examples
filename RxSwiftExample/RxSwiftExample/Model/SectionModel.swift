//
//  SectionModel.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 6.05.2022.
//

import Foundation
import RxDataSources

// Burada bir section model oluşturduk. Her bir section için header ve items var. Header'a göre sectionları ayırıp item'leri yerleştirebiliriz. Farklı cellType'larını tableView'da gösterebiliriz.
struct SectionModel {
    var header: String
    var items: [Food]
}

extension SectionModel : SectionModelType {
    
    init(original: SectionModel, items: [Food]) {
        self = original
        self.items = items
    }
}
