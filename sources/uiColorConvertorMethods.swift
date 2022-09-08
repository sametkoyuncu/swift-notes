import UIKit
import RealmSwift

struct Functions {
    // convert from UIColor to List<Double>
    static func getListFromUIColor(for color: UIColor) -> List<Double> {
        let components = color.cgColor.components ?? [1.0, 1.0, 1.0, 1.0]
        
        let doubleList = List<Double>()
        doubleList.append(components[0])
        doubleList.append(components[1])
        doubleList.append(components[2])
        doubleList.append(components[3])
        
        return doubleList
    }
    // convert from UIColor to List<Double>
    static func getUIColorFromList(for list: List<Double>?) -> UIColor {
        if let listDouble = list {
            let color = UIColor(red: listDouble[0],
                                green: listDouble[1],
                                blue: listDouble[2],
                                alpha: listDouble[3])
            return color
        }
        
        // default value
        return UIColor.white
    }
    
}

// usage
let red = UIColor.red

let list = Functions.getListFromUIColor(for: red)
let color = Functions.getUIColorFromList(for: list)