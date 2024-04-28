//
//  userService.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/28/24.
//

import Foundation



import CoreData


class UserService {
    let context: NSManagedObjectContext


    init(context: NSManagedObjectContext) {
        self.context = context
    }


    // Create a new user
    func createUser(name: String, password: String) -> User? {
        // Validate input data
        guard !name.isEmpty, !password.isEmpty else {
            print("Validation failed: Name and password must not be empty.")
            return nil
        }


        // Check if user already exists
        if fetchUser(withName: name) != nil {
            print("A user with this username already exists.")
            return nil
        }


        // Create a new user object
        guard let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User else {
            // More detailed error diagnostics
            print("Failed to create User. Here's more info about the context and its model:")
            print("Managed Object Context: \(context)")
            print("Persistent Store Descriptions: \(context.persistentStoreCoordinator?.persistentStores.description ?? "No Stores")")
            print("Entities in Model: \(context.persistentStoreCoordinator?.managedObjectModel.entitiesByName.keys.joined(separator: ", ") ?? "No entities")")
            return nil
        }

        newUser.name = name
        newUser.password = hashPassword(password) // Hash password for security


        // Save the user to the CoreData database
        do {
            try context.save()
            print("User saved successfully!")
            return newUser
        } catch {
            print("Failed to save user: \(error)")
            return nil
        }
    }


    func hashPassword(_ password: String) -> String {
        // Simple hashing for demonstration; use a proper hashing algorithm in production!
        return String(password.reversed())
    }


    // Fetch a user by name
    func fetchUser(withName name: String) -> User? {
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let results = try context.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }


    // Update user details
    func updateUser(user: User, name: String?, password: String?) {
        if let name = name {
            user.name = name
        }
        if let password = password {
            user.password = hashPassword(password) // Remember to hash this in a real app
        }
        do {
            try context.save()
        } catch {
            print("Failed to update user: \(error)")
        }
    }


    // Delete a user
    func deleteUser(user: User) {
        context.delete(user)
        do {
            try context.save()
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
}
