# How to create a constants file?

- Create a new `Constants.swift` file.

- Create a Struct inside the `Constants.swift` file. You name the file `Constants`, `K`, or what you want. :)

- Add `static let` properties to the Struct. Like below.

```swift
struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    // If you wish, you can add a group for similar content.
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
```

### Usage

- `print(K.cellIdentifier)`
- `print(K.BrandColors.purple)`
