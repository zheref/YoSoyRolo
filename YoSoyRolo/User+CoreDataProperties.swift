//
//  User+CoreDataProperties.swift
//  YoSoyRolo
//
//  Created by Sergio Daniel Leztark on 5/30/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var phone: String?
    @NSManaged var words: NSOrderedSet?
    @NSManaged var phrases: NSOrderedSet?

}
