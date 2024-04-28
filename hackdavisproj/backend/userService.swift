//
//  userService.swift
//  hackdavisproj
//
//  Created by Nathan Nguyen on 4/27/24.
//

import Foundation

import CoreData

class UserService {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // Create a new user
    func createUser(name: String, email: String, password: String, skills: [String]) -> User? {
        let newUser = User(context: context)
        newUser.name = name
        newUser.email = email
        newUser.password = password
        newUser.skills = skills


        do {
            try context.save()
            return newUser
        } catch {
            print("Failed to save user: \(error)")
            return nil
        }
    }




    // Fetch a user by email
    func fetchUser(withEmail email: String) -> User? {
            let request: NSFetchRequest<User> = User.fetchRequest() as! NSFetchRequest<User>
            request.predicate = NSPredicate(format: "email == %@", email)
            do {
                let results = try context.fetch(request)
                return results.first
            } catch {
                print("Failed to fetch user: \(error)")
                return nil
            }
        }



    // Update user details
    func updateUser(user: User, name: String?, email: String?, password: String?, skills: [String]?) {
        if let name = name {
            user.name = name
        }
        if let email = email {
            user.email = email
        }
        if let password = password {
            user.password = password // Remember to hash this in a real app
        }
        if let skills = skills {
            user.skills = skills
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
