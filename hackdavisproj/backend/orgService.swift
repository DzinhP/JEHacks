//
//  orgService.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation

import CoreData

class OrgService {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // Create
    func createOrganization(name: String, location: String, contactInfo: String, descriptionText: String) {
        let newOrganization = Organization(context: context)
        newOrganization.name = name
        newOrganization.location = location
        newOrganization.contactInfo = contactInfo
        newOrganization.descriptionText = descriptionText
        
        
        do {
            try context.save()
            print("Organization saved successfully!")
        } catch {
            print("Failed to save organization: \(error)")
        }
    }
    func fetchOrganization(withName name: String) -> Organization? {
        let request: NSFetchRequest<Organization> = Organization.fetchRequest() as! NSFetchRequest<Organization>// Correctly initialize the fetch request with the type
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let results = try context.fetch(request)
            return results.first  // Return the first matching Organization
        } catch {
            print("Failed to fetch organization: \(error)")
            return nil
        }
    }

        // Update an organization
        func updateOrganization(organization: Organization, newName: String?, newLocation: String?, newContactInfo: String?, newDescriptionText: String?) {
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
                organization.descriptionText = newDescriptionText
            }


            do {
                try context.save()
                print("Organization updated successfully!")
            } catch {
                print("Failed to update organization: \(error)")
            }
        }


        // Delete an organization
        func deleteOrganization(organization: Organization) {
            context.delete(organization)


            do {
                try context.save()
                print("Organization deleted successfully!")
            } catch {
                print("Failed to delete organization: \(error)")
            }
        }

    
    
    
    
}

