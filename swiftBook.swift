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