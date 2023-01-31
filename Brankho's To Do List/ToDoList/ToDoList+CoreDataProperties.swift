//
//  ToDoList+CoreDataProperties.swift
//  Brankho's To Do List
//
//  Created by BerkH on 31.01.2023.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var name: String?

}

extension ToDoList : Identifiable {

}
