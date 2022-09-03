# Core Data

### Adding CoreData to existing project

- Create new data model file: `Xcode` > `File` > `New` > `File` > `DataModel`
- Update `AppDelegate.swift` file

```swift
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

    // MARK: - Core Data stack
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

    // MARK: - Core Data Saving support
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
```

- Create your entities using `DataModel` file
- Done! 🎉

### CREATE/SAVE data

```swift
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
```

### READ data

```swift
// Item is our entity
let request: NSFetchRequest<Item> = Item.fetchRequest()
do {
    itemArray = try context.fetch(request)
} catch {
    print("Error fetching data from context, \(error)")
}
```

### UPDATE data

```swift
itemArray[indexPath.row].setValue("Updated item", forKey: "title")
// or
itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
// and after
context.save() // inside do-catch block
```

### DELETE/DESTROY data

```swift
context.delete(itemArray[indexPath.row]) // must be first
itemArray.remove(at: indexPath.row)
// and after
context.save() // inside do-catch block
```

### QUERYING data

#### Useful Documents

- [NSPredicate Cheatsheet](https://static.realm.io/downloads/files/NSPredicateCheatsheet.pdf)
- [NSPredicate by NSHipster](https://nshipster.com/nspredicate/)

#### Querying using Search Bar

```swift
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
                // c: case insensetive d: diacritic insensetive
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

            do {
                itemArray = try context.fetch(request)
            } catch {
                print("Error fetching data from context, \(error)")
            }

            tableView.reloadData()
        }
    }
}
```
