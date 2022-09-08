# UIColor Converter (Sample) Methods

### Methods

> I used `List<Double>` because I want to save it to the `Realm`. You can change the `List<Double>` to what you want from collection types. e.g `[Double]`

```swift
struct Functions {
    // convert from UIColor to List<Double>
    // I used List because, I want to save realm db.
    // you can change 'List<Double>' to what you want?
    // like: [Double] etc.
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
```

### Usage

```swift
let red = UIColor.red

let list = Functions.getListFromUIColor(for: red)
let color = Functions.getUIColorFromList(for: list)
```
