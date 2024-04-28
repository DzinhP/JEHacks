//
//  user.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var password: String
    @NSManaged public var skills: [String]
}


