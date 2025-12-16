# How to use RealmSwift?

### What is Realm Swift?

Realm Swift is an easy to use alternative to SQLite and Core Data that makes persisting, querying, and syncing data as simple as working directly with native Swift objects. [Visit to RealmSwift page 👆](https://realm.io/realm-swift/)

## Quick Start

- Initilation realm - `Appdelegate.swift`

```swift
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
```

- Define your models like regular Swift classes

  1. Todo App Models:
     a. We have 2 models, Category and Item.
     b. The relationship between the 2 models is '1-to-n'.
     c. '1' category have 'many' items otherwise '1' item have just '1' category.
  2. `Category.swift`file for Category Model

  ```swift
    import Foundation
    import RealmSwift

    class Category: Object {
        @Persisted var name: String = ""
        @Persisted var items = List<Item>()
    }
  ```

  3. `Item.swift`file for Item Model

  ```swift
    import Foundation
    import RealmSwift

    class Category: Object {
        @Persisted var title: String = ""
        @Persisted var isDone: Bool = false
        @Persisted var createdAt: Double = Date().timeIntervalSince1970
        var parentCategory = LinkingObjects.init(fromType: Category.self, property: "items")
    }
  ```

  ## CRUD

  ### CREATE

  - Add a new category

  ```swift
    import RealmSwift
    /* create a new instence from Realm */
    let localRealm = try! Realm()
        /* create a new category */
    let newCategory = Category()
    newCategory.name = newName
        /* save category to Realm db */
    do {
        try localRealm.write({
            localRealm.add(newCategory)
        })
    } catch {
        print("Error saving category, \(error)")
    }
  ```

  - Add a new item

  ```swift
    import RealmSwift
    let localRealm = try! Realm()

    /* Coming from category controller */
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
  ```

  ### READ

  - read categories

  ```swift
    /* auto-updating container, we don't need '.append()' method anymore */
    var categories: Results<Category>?
    categories = localRealm.objects(Category.self)
  ```

  - read items for selected categories

  ```swift
    var todoItems: Results<Item>?
    todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
  ```

  ### UPDATE

  - update item

  ```swift
    /* indexPath.row = item index. write any index you want. */
    if let item = todoItems?[indexPath.row] {
        do {
            try localRealm.write({
                item.isDone = !item.isDone
            })
        } catch {
            print("Error updating item, \(error)")
        }
    }
  ```

  ### DELETE

  - delete item

  ```swift
    /* indexPath.row = item index. write any index you want. */
    if let item = todoItems?[indexPath.row] {
    do {
        try localRealm.write({
            localRealm.delete(item)
        })
    } catch {
        print("Error deleting item, \(error)")
    }
  ```
