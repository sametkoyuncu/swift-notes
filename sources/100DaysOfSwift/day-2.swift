//! Day 2
//? source -> https://www.hackingwithswift.com/100/2

//* Arrays
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

print(beatles[1]) // Paul McCartney

//* Sets
// Sets are collections of values just like arrays, except they have two differences:

// Items aren’t stored in any order; they are stored in what is effectively a random order.
// No item can appear twice in a set; all items must be unique.
// You can create sets directly from arrays, like this:
let colors = Set(["red", "green", "blue"])

// When you look at the value of colors inside the playground output you’ll see it doesn’t match the order we used to create it. It’s not really a random order, it’s just unordered – Swift makes no guarantees about its order. Because they are unordered, you can’t read values from a set using numerical positions like you can with arrays.

// If you try to insert a duplicate item into a set, the duplicates get ignored. For example:
let colors2 = Set(["red", "green", "blue", "red", "blue"])

// The final colors2 set will still only include red, green, and blue once.

//* Tuples
// Tuples allow you to store several values together in a single value. That might sound like arrays, but tuples are different:

// You can’t add or remove items from a tuple; they are fixed in size.
// You can’t change the type of items in a tuple; they always have the same types they were created with.
// You can access items in a tuple using numerical positions or by naming them, but Swift won’t let you read numbers or names that don’t exist.
// Tuples are created by placing multiple items into parentheses, like this:
var name = (first: "Taylor", last: "Swift")

// You then access items using numerical positions starting from 0:
print(name.0)

// Or you can access items using their names:
print(name.first)

// Remember, you can change the values inside a tuple after you create it, but not the types of values. So, if you tried to change name to be (first: "Justin", age: 25) you would get an error.

//* Arrays vs sets vs tuples
// Arrays, sets, and tuples can seem similar at first, but they have distinct uses. To help you know which to use, here are some rules.

// If you need a specific, fixed collection of related values where each item has a precise position or name, you should use a tuple:
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

//If you need a collection of values that must be unique or you need to be able to check whether a specific item is in there extremely quickly, you should use a set:
let set = Set(["aardvark", "astronaut", "azalea"])

// If you need a collection of values that can contain duplicates, or the order of your items matters, you should use an array:
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

// Arrays are by far the most common of the three types.

//* Dictionaries
// Dictionaries are collections of values just like arrays, but rather than storing things with an integer position you can access them using anything you want.

// The most common way of storing dictionary data is using strings. For example, we could create a dictionary that stores the height of singers using their name:
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

// Just like arrays, dictionaries start and end with brackets and each item is separated with a comma. However, we also use a colon to separate the value you want to store (e.g. 1.78) from the identifier you want to store it under (e.g. “Taylor Swift”).

// These identifiers are called keys, and you can use them to read data back out of the dictionary:
print(heights["Taylor Swift"])
// Note: When using type annotations, dictionaries are written in brackets with a colon between your identifier and value types. For example, [String: Double] and [String: String].

//* Dictionary default values
// If you try to read a value from a dictionary using a key that doesn’t exist, Swift will send you back nil – nothing at all. While this might be what you want, there’s an alternative: we can provide the dictionary with a default value to use if we request a missing key.

// To demonstrate this, let’s create a dictionary of favorite ice creams for two people:
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

// We can read Paul’s favorite ice cream like this:
print(favoriteIceCream["Paul"])

// But if we tried reading the favorite ice cream for Charlotte, we’d get back nil, meaning that Swift doesn’t have a value for that key:
print(favoriteIceCream["Charlotte"])

// We can fix this by giving the dictionary a default value of “Unknown”, so that when no ice cream is found for Charlotte we get back “Unknown” rather than nil:
print(favoriteIceCream["Charlotte", default: "Unknown"])

//* Creating empty collections
// Arrays, sets, and dictionaries are called collections, because they collect values together in one place.

// If you want to create an empty collection just write its type followed by opening and closing parentheses. For example, we can create an empty dictionary with strings for keys and values like this:
var teams = [String: String]()

// We can then add entries later on, like this:
teams["Paul"] = "Red"

// Similarly, you can create an empty array to store integers like this:
var results = [Int]()

// The exception is creating an empty set, which is done differently:
var words = Set<String>()
var numbers = Set<Int>()

// This is because Swift has special syntax only for dictionaries and arrays; other types must use angle bracket syntax like sets.

// If you wanted, you could create arrays and dictionaries with similar syntax:
var scores = Dictionary<String, Int>()
var results = Array<Int>()

//* Enumerations
// Enumerations – usually called just enums – are a way of defining groups of related values in a way that makes them easier to use.

// For example, if you wanted to write some code to represent the success or failure of some work you were doing, you could represent that as strings:
let result = "failure"

// But what happens if someone accidentally uses different naming?
let result2 = "failed"
let result3 = "fail"

// All those three are different strings, so they mean different things.

// With enums we can define a Result type that can be either success or failure, like this:
enum Result {
    case success
    case failure
}

// And now when we use it we must choose one of those two values:
let result4 = Result.failure

// This stops you from accidentally using different strings each time.

//* Enum associated values
// As well as storing a simple value, enums can also store associated values attached to each case. This lets you attach additional information to your enums so they can represent more nuanced data.

// For example, we might define an enum that stores various kinds of activities:
enum Activity {
    case bored
    case running
    case talking
    case singing
}

// That lets us say that someone is talking, but we don’t know what they are talking about, or we can know that someone is running, but we don’t know where they are running to.

// Enum associated values let us add those additional details:
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

// Now we can be more precise – we can say that someone is talking about football:
let talking = Activity.talking(topic: "football")

//* Enum raw values
// Sometimes you need to be able to assign values to enums so they have meaning. This lets you create them dynamically, and also use them in different ways.

// For example, you might create a Planet enum that stores integer values for each of its cases:
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}

// Swift will automatically assign each of those a number starting from 0, and you can use that number to create an instance of the appropriate enum case. For example, earth will be given the number 2, so you can write this:
let earth = Planet(rawValue: 2)

// If you want, you can assign one or more cases a specific value, and Swift will generate the rest. It’s not very natural for us to think of Earth as the second planet, so you could write this:
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

// Now Swift will assign 1 to mercury and count upwards from there, meaning that earth is now the third planet.

//* Complex types: Summary
// You’ve made it to the end of the second part of this series, so let’s summarize:
/*
    - Arrays, sets, tuples, and dictionaries let you store a group of items under a single value. They each do this in different ways, so which you use depends on the behavior you want.
    - Arrays store items in the order you add them, and you access them using numerical positions.
    - Sets store items without any order, so you can’t access them using numerical positions.
    - Tuples are fixed in size, and you can attach names to each of their items. You can read items using numerical positions or using your names.
    - Dictionaries store items according to a key, and you can read items using those keys.
    - Enums are a way of grouping related values so you can use them without spelling mistakes.
    - You can attach raw values to enums so they can be created from integers or strings, or you can add associated values to store additional information about each case.
*/