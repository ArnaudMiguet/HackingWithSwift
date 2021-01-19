//
//  Commit+CoreDataClass.swift
//  Project38-GithubCommits
//
//  Created by Arnaud Miguet on 19.01.21.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("Init called!")
    }
}
