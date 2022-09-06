//* What is Realm Swift?
// Realm Swift is an easy to use alternative to SQLite and Core Data that makes persisting, querying, and syncing data as simple as working directly with native Swift objects. Visit to website -> https://realm.io/realm-swift/

//* Quick start
// initilation realm - Appdelegate.swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // realm db location 
            // print(Realm.Configuration.defaultConfiguration.fileURL)
        // checking connection
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }

// Define your models like regular Swift classes
    // Todo App
    // We have 2 models, Category and Item.
    // The relationship between the 2 models is '1-to-n'.
    // '1' category have 'many' items otherwise '1' item have just '1' category.

// Category.swift
import Foundation
import RealmSwift

class Category: Object {
     @Persisted var name: String = ""
    @Persisted var items = List<Item>()
}

// Item.swift
import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var isDone: Bool = false
    @Persisted var createdAt: Double = Date().timeIntervalSince1970
    var parentCategory = LinkingObjects.init(fromType: Category.self, property: "items")
}
//* CRUD
//* CREATE
// Add a new category
import RealmSwift
    // create a new instence from Realm
let localRealm = try! Realm()
    // create a new category 
let newCategory = Category()
newCategory.name = newName
    // save category to Realm db
do {
    try localRealm.write({
        localRealm.add(newCategory)
    })
} catch {
    print("Error saving category, \(error)")
}
// create item
import RealmSwift
let localRealm = try! Realm()

// Coming from category controller
var selectedCategory: Category? {
    didSet{
        loadItems()
    }
}

if let currentCategory = self.selectedCategory {
    do {
        try self.localRealm.write({
            let newItem = Item()
            newItem.title = newTitle
            currentCategory.items.append(newItem)
        })
    } catch  {
        print("Error saving new item, \(error)")
    }
}

//* READ
// Read categories
// auto-updating container, we don't need '.append()' method anymore
var categories: Results<Category>?
categories = localRealm.objects(Category.self)

// Read items for selected category
var todoItems: Results<Item>?
todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

//* UPDATE
// Update item
// indexPath.row = item index. write any index you want.
if let item = todoItems?[indexPath.row] {
    do {
        try localRealm.write({
            item.isDone = !item.isDone
        })
    } catch {
        print("Error updating item, \(error)")
    }
}

//* DELETE
// Delete item
// indexPath.row = item index. write any index you want.
if let item = todoItems?[indexPath.row] {
    do {
        try localRealm.write({
            localRealm.delete(item)
        })
    } catch {
        print("Error deleting item, \(error)")
    }
}