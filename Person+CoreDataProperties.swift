//
//  Person+CoreDataProperties.swift
//  CoreData-Example
//
//  Created by ukseung.dev on 9/2/24.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var updateDate: Date?

}

extension Person : Identifiable {

}
