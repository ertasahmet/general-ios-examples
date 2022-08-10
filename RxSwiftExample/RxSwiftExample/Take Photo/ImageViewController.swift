//
//  ImageViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 27.07.2022.
//

import UIKit

class ImageViewController: UIViewController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Burada dispatch queue grubu oluşturuyoruz.
        let group = DispatchGroup()
        
        // Burada bir queue oluşturuyoruz ve group'unu belirtiyoruz.
        let queue1 = DispatchQueue(label: "first")
        queue1.async(group: group) {
            sleep(5)
            print("This is the first queue")
        }
        
        // Burada da bir queue oluşturuyoruz ve group'unu belirtiyoruz.
        let queue2 = DispatchQueue(label: "second")
        queue2.async(group: group) {
            sleep(2)
            print("This is the second queue")
        }
        
        // Yukarıdaki iki grup ayrı ayrı işlemlerini yapıyorlar. Eğer ikisinin de bitiminden haberdar olmak istiyorsak group.notify ile dinleyebiliriz.
        group.notify(queue: DispatchQueue.main) {
            print("All have been executed")
            self.view.backgroundColor = .yellow
        }
    }
    
}
