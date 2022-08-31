import UIKit

let defaults = UserDefaults.standard

// set data
defaults.set(0.24, forKey: "Volume") // Double or Float
defaults.set("Ohaok", forKey: "PlayerName")         // String
defaults.set(Date(), forKey: "AppLastOpenedByUser") // Any

let array = [1, 2, 3, 4]
defaults.set(array, forKey: "myArray")

let dictionary = [404: "page not found", 200: "Ok"]
// defaults.set(dictionary, forKey: "statusCodes") // error ?



// get data
let volume = defaults.float(forKey: "Volume")
let playerName = defaults.string(forKey: "PlayerName")
let appLastOpened = defaults.object(forKey: "AppLastOpenedByUser")

let myArray = defaults.array(forKey: "myArray") as! [Int] // because set optional
let myDictionary = defaults.dictionary(forKey: "statusCodes")

