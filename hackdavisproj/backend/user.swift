//
//  user.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation
import CoreData

func createUser(name: String, email: String, skills: [String], context: NSManagedObjectContext) {
    let newUser = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context) as! Entity
    newUser.name = name
    newUser.email = email
    newUser.skills = skills

    do {
        try context.save()
        print("User saved successfully!")
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

