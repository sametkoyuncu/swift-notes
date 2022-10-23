//! Day 1
//? source -> https://www.hackingwithswift.com/100/1
//* Variables
// That creates a new variable called str, giving it the value “Hello, playground”.
var str = "Hello, playground"
// str is a variable we can change it.
str = "Goodbye"
// We don’t need var the second time because the variable has already been created – we’re just changing it.

//* Strings and integers
// Swift is what’s known as a type-safe language, which means that every variable must be of one specific type. The str variable that Xcode created for us holds a string of letters that spell “Hello, playground”, so Swift assigns it the type String.

// On the other hand, if we want to store someone’s age we might make a variable like this:
var age = 38

// If you have large numbers, Swift lets you use underscores as thousands separators – they don’t change the number, but they do make it easier to read. For example:
var population = 8_000_000

// Strings and integers are different types, and they can’t be mixed. So, while it’s safe to change str to “Goodbye”, I can’t make it 38 because that’s an Int not a String.

//* Multi-line strings
// Standard Swift strings use double quotes, but you can’t include line breaks in there.
// If you want multi-line strings you need slightly different syntax: start and end with three double quote marks, like this:
var str1 = """
This goes
over multiple
lines
"""

// If you only want multi-line strings to format your code neatly, and you don’t want those line breaks to actually be in your string, end each line with a \, like this:
var str2 = """
This goes \
over multiple \
lines
"""

//* Doubles and booleans
// “Double” is short for “double-precision floating-point number”, and it’s a fancy way of saying it holds fractional values such as 38.1, or 3.141592654.

// Whenever you create a variable with a fractional number, Swift automatically gives that variable the type Double. For example:
var pi = 3.141

// Doubles are different from integers, and you can’t mix them by accident.

// As for booleans, they are much simpler: they just hold either true or false, and Swift will automatically assign the boolean type to any variable assigned either true or false as its value.

// For example:
var awesome = true

//* String interpolation

// You’ve seen how you can type values for strings directly into your code, but Swift also has a feature called string interpolation – the ability to place variables inside your strings to make them more useful.

// You can place any type of variable inside your string – all you have to do is write a backslash, \, followed by your variable name in parentheses. For example:
var score = 85
var str = "Your score was \(score)"

//* Constants
// I already said that variables have that name because their values can change over time, and that is often useful. However, very often you want to set a value once and never change it, and so we have an alternative to the var keyword called let.

// The let keyword creates constants, which are values that can be set once and never again. For example:
let taylor = "swift"

//*
// Swift assigns each variable and constant a type based on what value it’s given when it’s created. So, when you write code like this Swift can see it holds a string:
let str = "Hello, playground"

// That will make str a string, so you can’t try to assign it an integer or a boolean later on. This is called type inference: Swift is able to infer the type of something based on how you created it.

// If you want you can be explicit about the type of your data rather than relying on Swift’s type inference, like this:
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true

// Notice that booleans have the short type name Bool, in the same way that integers have the short type name Int.

//* Simple types: Summary
/*
    You’ve made it to the end of the first part of this series, so let’s summarize.
    
    - You make variables using var and constants using let. It’s preferable to use constants as often as possible.
    - Strings start and end with double quotes, but if you want them to run across multiple lines you should use three sets of double quotes.
    - Integers hold whole numbers, doubles hold fractional numbers, and booleans hold true or false.
    - String interpolation allows you to create strings from other variables and constants, placing their values inside your string.
    - Swift uses type inference to assign each variable or constant a type, but you can provide explicit types if you want.
*/