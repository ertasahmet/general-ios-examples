//
//  PersonViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 21.05.2022.
//

import UIKit
import RealmSwift

class PersonViewController: UIViewController {

    let viewModel = PersonViewModel()
    var notificationToken: NotificationToken?
    var people: Results<Person>!
    let realm = PersonRealmService.shared.realm
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Burası realm db'si değiştiğinde tetikleniyor.
        notificationToken = viewModel.realm.observe({ notification, realm in
            
            // self.tableView.reloadData()
        })
        
        // Bu da db'de oluşan errorları handle etmemizi sağlıyor.
        PersonRealmService.shared.observeRealmErrors(in: self) { (error) in
            // Error handling
            print(error ?? "no error")
        }
        
       // addPerson()
        
        people = realm.objects(Person.self)
        deletePerson()
        print(people)
        getFilteredPerson()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Sayfa kapandığında memory'de yer yememek için observer'ları siliyoruz.
        notificationToken?.invalidate()
        PersonRealmService.shared.stopObservingErrors(in: self)
    }
    
    // Db'ye person eklemek için ilgili class'ları oluşturuyoruz ve sonra ekliyoruz.
    func addPerson() {
        let userPassport = Passport("pass1")
        
        let todo1 = Todo("RxSwift", "Rxswift iyidir be abi")
        let todo2 = Todo("Programmatic UI", "Programmatic UI öğren reis")
        
        let person = Person(4, "Ahmet")
        person.passport = userPassport
        person.isEmailSubscriptionEnable.value = nil
        person.todos.append(objectsIn: [todo1, todo2])
        person.type = .gold
        
        // Burada person'daki custom property'e ulaştık.
        print(person.isUserHasTodos)
        
        // Passport üzerinden user'a ulaştık.
        print(userPassport.ofUser.first?.firstName ?? "No element")
        
        // todo üzerinden yine person class'ına ulaştık.
        print(todo1.ofUser.first?.userId)
        
        // Burada da person ekleme metodunu çağırdık.
        viewModel.addPerson(person)
    }
    
    // Filter işlemi
    func getFilteredPerson() {
        let personsWithExactMatch = realm.objects(Person.self)
            .filter("firstName == 'Ahmet'")
            .sorted(byKeyPath: "firstName")
        
        print(personsWithExactMatch.count)
    }
    
    // Güncelleme işlemi
    func modifyPerson() {
        let person = people.last
        let dict = ["firstName": "Ahmet Abi QQQQ9", "passport": Passport("pass yeni")] as [String : Any]
        if let person = person {
            viewModel.updatePerson(person, dict)
        }
        
    }
    
    // Silme işlemi. Person listeden id'ye göre person'a ulaşıp onu siliyoruz.
    func deletePerson() {
        let person = people.last
        if let person = person {
            viewModel.deletePerson(person)
        }
        
    }

}
