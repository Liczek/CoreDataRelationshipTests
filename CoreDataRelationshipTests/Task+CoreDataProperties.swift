//
//  Task+CoreDataProperties.swift
//  CoreDataRelationshipTests
//
//  Created by Paweł Liczmański on 11.07.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var name: String?
    @NSManaged public var categoryName: Int64
    @NSManaged public var category: Category?

}
