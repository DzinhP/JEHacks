import XCTest
import CoreData
@testable import hackdavisproj // Replace MyApp with your actual module name


class UserServiceTests: XCTestCase {
    
    var userService: UserService!
    var context: NSManagedObjectContext!


    override func setUp() {
        super.setUp()
        // Set up an in-memory Core Data stack
        context = setUpInMemoryManagedObjectContext()
        userService = UserService(context: context)
    }


    override func tearDown() {
        userService = nil
        context = nil
        super.tearDown()
    }


    func testCreateUser() {
        userService.createUser(name: "John Doe", email: "john@example.com", password: "password123", skills: ["iOS Development"])
        let fetchedUser = userService.fetchUser(withEmail: "john@example.com")
        XCTAssertNotNil(fetchedUser, "User should not be nil")
        XCTAssertEqual(fetchedUser?.name, "John Doe", "User name should be 'John Doe'")
        XCTAssertEqual(fetchedUser?.email, "john@example.com", "User email should match")
    }

    func testFetchUser() {
        userService.createUser(name: "Jane Doe", email: "jane@example.com", password: "passwordSecure", skills: ["Swift"])
        let fetchedUser = userService.fetchUser(withEmail: "jane@example.com")
        XCTAssertNotNil(fetchedUser, "Fetched user should not be nil")
        XCTAssertEqual(fetchedUser?.name, "Jane Doe", "Fetched user name should match")
    }


    func testUpdateUser() {
         let user = userService.createUser(name: "Alice Smith", email: "alice@example.com", password: "pass1234", skills: ["Objective-C"])
         userService.updateUser(user: user!, name: "Alice Johnson", email: nil, password: nil, skills: nil)
         XCTAssertEqual(user?.name, "Alice Johnson", "User name should be updated to 'Alice Johnson'")
     }



    func testDeleteUser() {
        let user = userService.createUser(name: "Bob Brown", email: "bob@example.com", password: "123456", skills: ["Android Development"])
        userService.deleteUser(user: user!)
        let fetchedUser = userService.fetchUser(withEmail: "bob@example.com")
        XCTAssertNil(fetchedUser, "User should be deleted")
    }


    // Helper method to set up an in-memory Core Data stack
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)


        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            fatalError("Adding in-memory persistent store failed")
        }


        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }
}





