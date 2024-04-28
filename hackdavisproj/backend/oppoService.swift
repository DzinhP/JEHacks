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
        let newOppo = Oppor(context: context)
        newOppo.title = title
        newOppo.descript = descriptionText
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
    func fetchOpportunity(withTitle title: String) -> Oppor? {
        let request: NSFetchRequest<Oppor> = Oppor.fetchRequest() as! NSFetchRequest<Oppor>
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
    func updateOpportunity(opportunity: Oppor, newTitle: String?, newDescriptionText: String?, newRequirements: [String]?, newDate: Date?, newLocation: String?) {
        if let newTitle = newTitle {
            opportunity.title = newTitle
        }
        if let newDescriptionText = newDescriptionText {
            opportunity.descript = newDescriptionText
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
    func deleteOpportunity(opportunity: Oppor) {
        context.delete(opportunity)


        do {
            try context.save()
            print("Opportunity deleted successfully!")
        } catch {
            print("Failed to delete opportunity: \(error)")
        }
    }
}




