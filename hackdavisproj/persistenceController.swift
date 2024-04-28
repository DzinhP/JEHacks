import CoreData


struct PersistenceController {
    static let shared = PersistenceController()  // Used by the main app
    static let preview = PersistenceController(inMemory: true)  // Used for previews


    let container: NSPersistentContainer


    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "data")  // Replace "ModelName" with your actual model name
        if inMemory {
            // Configure the container to use an in-memory store
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }


    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
}
