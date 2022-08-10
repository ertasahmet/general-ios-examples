//
//  APICaller.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 18.07.2022.
//

import Foundation

class APICaller {
    public var isPaginating = false
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            self.isPaginating = true
        }
        
        // Burada pagination varsa 3 saniye yoksa 2 saniye bekle ve verileri öyle getir diyoruz.
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let originalData = [
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Microsoft",
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Microsoft",
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Microsoft",
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Microsoft",
            "Apple",
            "Google"
            ]
            
            let newData = ["Banana", "Oranges", "Grapes", "Food", "Pizza", "Pasta"]
            
            // Burada da pagination varsa newData listesini yoksa normal listeyi dön diyoruz.
            completion(.success(pagination ? newData : originalData))
            
            if pagination {
                self.isPaginating = false
            }
        })
    }
}
