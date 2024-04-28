//
//  orgService.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/28/24.
//

import Foundation
import CoreData


class OrganizationService {
    let context: NSManagedObjectContext


    init(context: NSManagedObjectContext) {
        self.context = context
    }


    // Create a new organization
    func createOrganization(name: String, location: String, contactInfo: String, descriptionText: String) {
        let newOrganization = Org(context: context)
        newOrganization.name = name
        newOrganization.location = location
        newOrganization.contactInfo = contactInfo
        newOrganization.descript = descriptionText


        do {
            try context.save()
            print("Organization saved successfully!")
        } catch {
            print("Failed to save organization: \(error)")
        }
    }


    // Fetch an organization by name
    func fetchOrganization(withName name: String) -> Org? {
        let request: NSFetchRequest = NSFetchRequest<Org>(entityName: "Org")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch organization: \(error)")
            return nil
        }
    }


    // Update an organization
    func updateOrganization(organization: Org, newName: String?, newLocation: String?, newContactInfo: String?, newDescriptionText: String?) {
        if let newName = newName {
            organization.name = newName
        }
        if let newLocation = newLocation {
            organization.location = newLocation
        }
        if let newContactInfo = newContactInfo {
            organization.contactInfo = newContactInfo
        }
        if let newDescriptionText = newDescriptionText {
            organization.descript = newDescriptionText
        }


        do {
            try context.save()
            print("Organization updated successfully!")
        } catch {
            print("Failed to update organization: \(error)")
        }
    }


    // Delete an organization
    func deleteOrganization(organization: Org) {
        context.delete(organization)


        do {
            try context.save()
            print("Organization deleted successfully!")
        } catch {
            print("Failed to delete organization: \(error)")
        }
    }
}
