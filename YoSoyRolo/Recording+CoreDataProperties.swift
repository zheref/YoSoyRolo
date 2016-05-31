//
//  Recording+CoreDataProperties.swift
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

extension Recording {

    @NSManaged var uri: String?
    @NSManaged var word: Word?
    @NSManaged var phrase: Phrase?

}
