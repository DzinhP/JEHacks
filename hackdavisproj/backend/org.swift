//
//  org.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation
import CoreData


@objc(Organization)
public class Organization: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var location: String
    @NSManaged public var contactInfo: String
    @NSManaged public var descript: String // 'description' is a reserved word in NSObject
}
