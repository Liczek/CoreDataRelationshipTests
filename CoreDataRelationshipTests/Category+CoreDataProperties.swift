//
//  Category+CoreDataProperties.swift
//  CoreDataRelationshipTests
//
//  Created by Paweł Liczmański on 03.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var name: String?

}
