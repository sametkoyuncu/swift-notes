# How to use UserDefaults?

> `UserDefaults` is a singleton object. For more details, please check my `singleton-object.md` file.

> An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app. - developer.apple.com

### Usage

- Create a new instence.

```swift
let defaults = UserDefaults.standard
```

- set data

```swift
defaults.set(0.24, forKey: "Volume")
defaults.set("Ohaok", forKey: "PlayerName")
defaults.set(Date(), forKey: "AppLastOpenedByUser")

let array = [1, 2, 3, 4]
defaults.set(array, forKey: "myArray")

let dictionary = [404: "page not found", 200: "Ok"]
// defaults.set(dictionary, forKey: "statusCodes") // error ?
```

-get data

```swift
let volume = defaults.float(forKey: "Volume")
let playerName = defaults.string(forKey: "PlayerName")
let appLastOpened = defaults.object(forKey: "AppLastOpenedByUser")

let myArray = defaults.array(forKey: "myArray") as! [Int] // because set optional
let myDictionary = defaults.dictionary(forKey: "statusCodes")
```

- For more info look this article. -> [UserDefaults](For more info look this article.)
