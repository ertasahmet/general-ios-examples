//
//  Note+CoreDataProperties.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 20.05.2022.
//

import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var lastUpdated: Date!
    @NSManaged public var text: String!

}
