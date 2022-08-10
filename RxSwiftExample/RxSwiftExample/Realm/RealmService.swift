//
//  RealmService.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 21.05.2022.
//

import Foundation
import RealmSwift

class RealmService {
    
    public init() {}
  //  static let shared = RealmService()
    private let notificationName = NSNotification.Name("RealmError")
    
    var realm = try! Realm()
    
    // Create metodu ile buraya hangi model class'ını verirsek onu db'ye ekliyor. Her model object olduğu için istediğimiz modeli tek metod ile ekleyebiliriz.
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            post(error)
        }
    }
    
    // Update için de değiştirmek istediğimiz objeyi gönderiyoruz, daha sonra dictionary olarak o model içinde geğiştirmek istediğimiz alanları gönderiyoruz. Mesela person class'ını değiştiricez, obje olarak onu gönderdik, değiştirmek istediğimzi alan sadece firstName ise dictionary'de onu gönderiyoruz ve sadece o değişiyor.
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    // Silmek istediğimiz objeyi gönderiyoruz ve siliyor.
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }
    
    // Hataları görüntülemek için burada observe olunacak bir bildirim gönderiyoruz. Hata geldiğinde postError ile bildirim gönderiyoruz ve viewController'da handle ediyoruz.
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: nil,
                                               queue: nil) { (notification) in
                                                completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: notificationName, object: nil)
    }
    
    private func post(_ error: Error) {
        NotificationCenter.default.post(name: notificationName, object: error)
    }
    
}
