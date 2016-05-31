//
//  Entry+CoreDataProperties.swift
//  Quotidian
//
//  Created by Sam on 5/30/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {

    @NSManaged var date: NSDate?
    @NSManaged var imageData: NSData?
    @NSManaged var location: String?
    @NSManaged var text: String?

}
