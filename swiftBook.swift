/*
     ? Basics
*/     
//* Declaring Constants and Veriables
let PI_NUMBER = 3.14 // constant - immutable
var counter = 0 // mutable

//* Type Annotations
var welcomeMessage: String

//* Printing Constants and Veriables
print(welcomeMessage)

//* or String Interpoletion
print("Some string \(welcomeMessage)")

//* Veriable Types
    // Integers
    // Int8, 16, 32, 64 / uint ...
    // How to learn bound?
    print("\(uint8.min) or \(uint16.max)")

    // Floating - Point Numbers
    // Float: 6 decimal digits
    // Double: 15
    // swift always chooces Double

//* Numeric Literals
    // no prefix: decimal numbers   -> 17
    // 0b: binary notation          -> 0b10001
    // 0o: octal notation           -> 0o21
    // 0x: hexadecimal notation     -> 0x11
    // 1.25e2 means 1.25 x 10**2
    // 1.25e-2 means 1.25 x 10**-2

//* Conversion
var intValue: Int = 5
var doubleValue = Double(intValue)

//* Type Aliases
    // Define an alternative name for an existing type.
    typealias AudioSample = uint16
    print(AudioSample.min) // print 0 because uint16

//* Tuples
    // Tuples group multiple values into a single compound value. The value within a tuple can be of anytype and don't have to be of the same type as each other.
    let http404Error = (404, "page not found") // (int, string)
    let (statusCode, statusMessage) = http404Error
    print(statusMessage) // page not found
    // or
    let (statusCode, _) = http404Error // ignore the second item
    // it likes object destructing in JS
    // or you can use like this:
    print(http404Error.0)
    print(http404Error.1)
    // or again. You can name the individual elements in a tuple when the tuple is defined.
    let http200Ok = (statusCode: 200, statusMessage: "Ok")
    // You can use the element names like this below
    print(http200Ok.statusCode)
    // ! Note: They (tuples) are not suited to the creation of complex data scructures.

//* Optionals
// You use optionals in situations where a value may be absent.
var serverResponseCode: Int? = 404
serverResponseCode = nil // contains no value
var serverAnswer: String? // automatically set to nil

// if statemets and forced unwrapping
if serverResponseCode != nil {
    print("Status Code: \(serverResponseCode)")
}

// optional binding
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}

// implicitly unwrapped optionals -> String!
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation point

// Error Handling
// Assertions and Preconditions
    // DEbugging with asertion
    assert(age >= 0, "A person's age can't be less than zero.")
    // Enforcing Preconditions
    precondition(index > 0, "Index must be greater than zero.")
    // Note: f you compile in unchecked mode (-Ounchecked), preconditions aren’t checked. 

/*
    ? Basic Operators
*/

//* +, -, *, /, %
//* Swift also provides range operators:
    // [1...5] -> 1, 2, 3, 4, 5   (closed range op.)
    // [1..<5] -> 1, 2, 3, 4      (half open range op.)
    // [2...] | [...2] | [..<2]   (one sided ranges)
        // for name in names[..2] etc.
//* ternary operator
    // a ? b : c
//* &+ -> overflow operator
//* Nil-Coalescing Operator ??
    // a ?? b -> if a is nil , check b. if a isn't nil skip the b.

/*
    ? Strings and Characters
*/
//* multiline string: """ lorem ipsum
//                       dolor sit amet
//                       lorem lorem """

//* special characters in string literals
// \0 -> null char
// \\ -> backslash
// \t -> horizontal tab
// \' -> single quatation mark
// \n -> line feed
// \r -> carriage return (satır başı)
// \" -> double quatation mark
// \u{n} -> unicode scalar value, where n is 1-8 digit hex number

// .isEmpty -> empty check
// for character in stringValue -> give letters
// stringValue.append(otherStringValue) -> concat
// \(veriable) -> string interpolatien

/*
    ? Collection Types
*/
//* Arrays
// ordered collection
// creating an array with a default value
var threeBoubles = Array(repating:0.0, count: 3) // [0.0, 0.0, 0.0]
// Accessing and Modifying an Array
    // array methods
        // array.count -> item count of the array
        // array.append -> add new item to the array
        // array.isEmpty ->  does the array have any items?
        // array.insert("new item", at: 2) -> add to specific index
        // array.remove(at: 2) -> remove from specific index
        // array.removeFirst() and array.removeLast()
        // array.enumarated() -> return (index, value) tuple in for-in loops
            for (index, value) in shoppingList.enumerated() {
                print("Item \(index + 1): \(value)")
            }
    // array += otherArray -> This works
    // array[4..6] = ["item 1", "item 2"] -> This also works 
