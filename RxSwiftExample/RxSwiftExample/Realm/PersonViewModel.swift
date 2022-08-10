//
//  PersonViewModel.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 21.05.2022.
//

import Foundation
import RealmSwift

class PersonViewModel {
    
    // Db'den çektiğimiz person'ları results şeklinde alıyoruz.
    var people: Results<Person>!
    let personService = PersonRealmService.shared
    let realm = PersonRealmService.shared.realm
    
    func getPeople() {
        people = realm.objects(Person.self)
    }
    
    func addPerson(_ person: Person) {
        personService.create(person)
    }
    
    func updatePerson(_ person: Person, _ dict: [String: Any]) {
        personService.update(person, with: dict)
    }
    
    func deletePerson(_ person: Person) {
        personService.delete(person)
    }
    
}
