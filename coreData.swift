//! Add CoreData to existing project.
//* create a new data model file named 'DataModel'
// File > New > File > DataModel

//* update 'AppDelegate.swift' file
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    /*
        other AppDelegate methods, if you need..
    */

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    //? MARK: - Core Data stack
    // lazy: A lazy var is a property whose initial value is not calculated until the first time it's called.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    //? MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//* create your entities
// entity: class, attribure: property

//* CREATE/SAVE data
import CoreData
// get context from appdelegate
let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
// create item
let newItem = Item(context: context)
newItem.title = "New item"
// save changes to db
do {
    try context.save()
} catch {
    print("Error saving context, \(error)")
}

//* READ data
// Item our entity
let request: NSFetchRequest<Item> = Item.fetchRequest()
do {
    itemArray = try context.fetch(request)
} catch {
    print("Error fetching data from context, \(error)")
}

//* UPDATE data
itemArray[indexPath.row].setValue("Updated item", forKey: "title")
// or
itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
// and after
context.save() // inside do-catch block

//* DELETE data
context.delete(itemArray[indexPath.row]) // must be first
itemArray.remove(at: indexPath.row)
// and after
context.save() // inside do-catch block