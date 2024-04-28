//
//  oppo.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation
import CoreData


@objc(Oppo)
public class Oppo: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var descriptionText: String // 'description' is a reserved word in NSObject
    @NSManaged public var requirements: [String] // This will be a transformable attribute
    @NSManaged public var date: Date
    @NSManaged public var location: String
}
