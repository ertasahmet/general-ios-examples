//
//  CallList.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 21.05.2022.
//

import Foundation
import RealmSwift

// UserType'lar için bir enum oluşturduk.
enum UserType: Int {
    case premium
    case gold
    case none
}

// Eğer class içindeki tüm propertylere @objc eklemek istiyorsak class'ı @objcMembers class diye tanımlamamız gerekir.
class Person : Object {
    
    // Modellerimizi burada belirtiyoruz. Değişken olarak başka bir object de koyabiliyoruz. List tipi Realm'ın bir tipidir. Burada hem bire çok hem de bire bir ilişki kullanıyoruz. 1 passport ve birden fazla todo 1 kullanıcıya tanımlı.
    @objc dynamic var userId = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var passport: Passport?
    @objc private dynamic var privateUserType: Int = UserType.none.rawValue
    let isEmailSubscriptionEnable = RealmProperty<Bool?>()
    let todos = List<Todo>()
    
    // Aşağılarda ise istediğimiz gibi custom property'lerimizi yazabiliriz.
    var isUserHasTodos: Bool {
        return todos.count > 0
    }
    
    var type: UserType {
        get { return UserType(rawValue: privateUserType)! }
        set { privateUserType = newValue.rawValue }
    }
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    // Constructor'da property'leri alabiliriz.
    convenience init(_ userId: Int, _ firstName: String) {
        self.init()
        self.userId = userId
        self.firstName = firstName
    }
    
}

// Passport diye class açıyoruz.
class Passport: Object {
    
    @objc dynamic var passportNumber = ""
    @objc dynamic var expiryDate = Calendar.current.date(byAdding: .day, value: 10, to: Date.now)
    
    // Burada linkingObjects diye person ile bağlantı kuruyoruz ve oradaki property'nin adının passport olduğunu belirtiyoruz.
    let ofUser = LinkingObjects(fromType: Person.self, property: "passport")
    
    convenience init(_ passportNumber: String) {
        self.init()
        self.passportNumber = passportNumber
    }
}

// Burada da todo class'ı oluşturuyoruz ve propertyleri ekledik.
class Todo: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var details = ""
    
    // Yine linkingOjects ile Person ile bağlantı kuruyoruz.
    let ofUser = LinkingObjects(fromType: Person.self, property: "todos")
    
    convenience init(_ name: String, _ details: String) {
        self.init()
        self.name = name
        self.details = details
    }
}
