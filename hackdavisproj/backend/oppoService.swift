//
//  oppoService.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation
import CoreData


class OppoService {
    let context: NSManagedObjectContext


    init(context: NSManagedObjectContext) {
        self.context = context
    }


    // Create a new opportunity
    func createOpportunity(title: String, descriptionText: String, requirements: [String], date: Date, location: String) {
        let newOppo = Oppo(context: context)
        newOppo.title = title
        newOppo.descriptionText = descriptionText
        newOppo.requirements = requirements
        newOppo.date = date
        newOppo.location = location


        do {
            try context.save()
            print("Opportunity saved successfully!")
        } catch {
            print("Failed to save opportunity: \(error)")
        }
    }


    // Fetch an opportunity by title
    func fetchOpportunity(withTitle title: String) -> Oppo? {
        let request: NSFetchRequest<Oppo> = Oppo.fetchRequest() as! NSFetchRequest<Oppo>
        request.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch opportunity: \(error)")
            return nil
        }
    }


    // Update an opportunity
    func updateOpportunity(opportunity: Oppo, newTitle: String?, newDescriptionText: String?, newRequirements: [String]?, newDate: Date?, newLocation: String?) {
        if let newTitle = newTitle {
            opportunity.title = newTitle
        }
        if let newDescriptionText = newDescriptionText {
            opportunity.descriptionText = newDescriptionText
        }
        if let newRequirements = newRequirements {
            opportunity.requirements = newRequirements
        }
        if let newDate = newDate {
            opportunity.date = newDate
        }
        if let newLocation = newLocation {
            opportunity.location = newLocation
        }


        do {
            try context.save()
            print("Opportunity updated successfully!")
        } catch {
            print("Failed to update opportunity: \(error)")
        }
    }


    // Delete an opportunity
    func deleteOpportunity(opportunity: Oppo) {
        context.delete(opportunity)


        do {
            try context.save()
            print("Opportunity deleted successfully!")
        } catch {
            print("Failed to delete opportunity: \(error)")
        }
    }
}




