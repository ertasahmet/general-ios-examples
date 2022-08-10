//
//  NoteViewModel.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 13.05.2022.
//

import Foundation
import RxSwift
import RxRelay
import CoreData

class NoteViewModel {
    
    // CoreData Manager'dan instance oluşturduk.
    let coreDataManager = CoreDataManager.shared
    
    // Publish olucak değişkenlerimizi ekledik.
    private var isSuccess = BehaviorRelay<Bool>(value: false)
    private var isAddedNew = BehaviorRelay<Bool>(value: false)
    private var notesModelSubject = PublishSubject<[Note]>()
    
    var notesModelObservable: Observable<[Note]> {
        return notesModelSubject
    }
    
    var isAddedNewObservable: Observable<Bool> {
        return isAddedNew.asObservable()
    }
    
    // Note ekleme metodumuz bu. VC'de burası çağırılıyor.
    func addNote() {
        coreDataManager.save() { isSuccess in
            isSuccess ? self.isSuccess.accept(true) : self.isSuccess.accept(false)
            self.isAddedNew.accept(true)
        }
    }
    
    // Notları buradan çekiyoruz.
    func fetchNotes() {
        // Eğer arama yapmak istiyorsak filter'a aramak istediğimiz string'i giriyoruz, eğer tüm notları istiyorsak filter parametresine değer göndermiyoruz.
        let notes = coreDataManager.fetchNotes()
        notesModelSubject.onNext(notes)
    }
    
    // Silme işlemi buradan.
    func deleteNote(_ note: Note) {
        coreDataManager.deleteNote(note)
    }
}
