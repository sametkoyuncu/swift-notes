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
//* Sets
// unordered and unique
var letters = Set<Character>() // create empty Set
var letters2: Set<Character> = ["a", "b", "c"]
letters2 = [] // letter s empty now, type still same

// methods
letters.insert("z") // add item to letters
letters.remove("z") // remove item from letters
letters.contains("a") // 
letters.removeAll() // remove all items from letters
letters.sorted() // sort items 

// fundamentals set operations
var a = Set<Character>()
var b = Set<Character>()
a.intersection(b)           // a ile b'nin kesişimi
a.union(b)                  // a ile b'nin birleşimi
a.symmetricDifference(b)    // a ile b'nin farklı elemanları birleşimi
a.subtracting(b)            // a'nın b'den farklı elemanları
// other methods
a.isSubset(of:b)
a.isSuperset(of:b)
a.Disjoint(with:b)
a.isStrictSubset(of:b)
a.isStrictSuperset(of:b)

//* Dictionaries
// (key: value)
var nameOfIntegers: [Int: String] = [:] // is an empty dictionary
nameOfIntegers[16] = "sixteen"
// key: 16, value: sixteen
nameOfIntegers.updateValue("Sixteen", forKey: 16)
nameOfIntegers.removeValue(forkey: 16) // return removed value
nameOfIntegers.key // return keys
nameOfIntegers.values // return values
nameOfIntegers.sorted()

/*
    ? Control Flow
*/
let numberOfLegs = ["spider":8, "ant":6, "cat":4]
//* for-in
for (animalName, legCount) in numberOrlegs { }
for index in 1...5 { }

//* coulddown #stride
for tickMark in stride(from: 0, to: 60, by: 5) {
    print(tickMark)
} // prints: 0, 5, 10, ..., 55
//! 'by' can be negative number like "-5"
//! to: -> <, > | through: -> <=, >=

//* while and repeat-while
while condition {
    statemets
}

repeat {
    statemets
} while condition

//* switch-case
switch number {
case 1...5:
    print("this works")
default:
    // default
}
    // switch-case with tuples
    switch value {
    case (0, 0):
    case (_, 0):
    case (0, _):
    case (-2...2, -2...2):
    default:
    }
// value binding
case(0, let y):
    print(y)

// where
switch point {
case let (x, y) where x==y:
    print("equal")
case let (x, y):
    print("not equal")
default:   
}
// compound cases
case a, b, c:

//* control transfer statements
continue
    // it says "I am done with the current loop iteration" without leaving the loop altogether.
fallthrough // eşlelsen tüm case'ler çalışır, normalde ilk eşleşen tamamlanır, çıkar
throw // described in error handling
break
    // ends execution of an entire control flow statement immediately
return // described in functions

//* labeled statements
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }

    switch square + diceRoll {
    case finalSquare:
        break gameLoop
    case let newSquare where newSquare > finalSquare
        continue gameLoop
    default:
        square += diceRoll
        square += board[square]
    }
}
print("Gamer over!")

//* Early Exit (a.k.a. Early Return)
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Welcome, \(name)")
}

//? checking API availability
// Swift has built-in support for checking API availability, which ensures that you don’t accidentally use APIs that are unavailable on a given deployment target.

/*
    ? Functions
*/

func printAndCount(str: String) -> Int {
    print(str)
    return str.count // return int
}

func printWithoutCount(str: String) {
    print(str)
}

// funtions can return tuple or multiple value with paranthesies

// argument and parameter names
func myFunc(argumentName parameterName: String) {
    print(parameterName)
}
myFunc(argumentName: "hello")

// omiting argument label with '_'
func myFunc(_ parameterName: String) {
    print(parameterName)
}
myFunc("hello")

//* Variadic Parameters
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for num in numbers {
        total += num
    }
    return total / numbers.count
}

//* in-out parameters
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

//* Function types
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
    // Using Function Types
    var mathFunction: (Int, Int) -> Int = addTwoInts
    print("Result: \(mathFunction(2, 3))")
    // Prints "Result: 5"

    // Function Types as Parameter Types
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
    printMathResult(addTwoInts, 3, 5)
    // Prints "Result: 8"

    // Function Types as Return Types
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }

    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }

//* Nested functions
// you can also define functions inside the  bodies of other functions, known as nested functions
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    // nested func
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
