//
//  Item+CoreDataProperties.swift
//  CoreDataRelationshipTests
//
//  Created by Paweł Liczmański on 03.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var name: String?
    @NSManaged public var category: Category?

}
