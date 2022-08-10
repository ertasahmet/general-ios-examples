//
//  CoreDataManager.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 13.05.2022.
//

import CoreData

class CoreDataManager {
    
    // Burada gerekli değişkenleri tanımladık.
    static let shared = CoreDataManager(modelName: "QuickNotes")
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    // Save ile değişiklikleri db'ye kaydediyoruz.
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }
    
    // Burada da completion ile save yaptık, success olup olmadığını görmek için bu şekilde yapıyoruz.
    func save(completion: @escaping (Bool) -> Void) {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                completion(true)
            } catch {
                completion(false)
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }
    
    // CoreData'yı initialize edince birşeyler yapmak isteyebiliriz. O yüzden buraya completion koyduk, eğer birşey yapmak istemezsek sadece load metodunu çağırırız.
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { desc, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    
    // MARK: Note Service
    
    func fetchNotes(filter: String? = nil) -> [Note] {
        
        // Db'den verileri çekmek için önce bir request oluşturuyoruz.
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        
        // NSSortDescriptor ile sıralama yapabiliyoruz.
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        // Filter var ise filtre uyguluyoruz, yoksa tüm notlar geliyor.
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        // Daha sonra verileri çekiyoruz. Fail olursa boş liste dönüyoruz.
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Fetch Error")
            return [Note]()
        }
    }
    
    // Burada da silme işlemi yapıyoruz.
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
    
  /*  func createNote(note: Note) -> Note? {
        let noteCD = Note(context: viewContext)
        noteCD.id = note.id
        noteCD.text = note.text
        noteCD.lastUpdated = note.lastUpdated
        save()
        return note
    }*/
    
}


