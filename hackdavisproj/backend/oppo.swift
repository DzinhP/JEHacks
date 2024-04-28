//
//  oppo.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation
import CoreData


@objc(Oppor)
public class Oppor: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var descript: String // 'description' is a reserved word in NSObject
    @NSManaged public var requirements: [String] // This will be a transformable attribute
    @NSManaged public var date: Date
    @NSManaged public var location: String
}
