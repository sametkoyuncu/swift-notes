struct Yemek {
    let name: String
    let count: Int
}

var y1 = Yemek(name: "makarna", count: 2)
var y2 = Yemek(name: "ayran", count: 3)
var y3 = Yemek(name: "baklava", count: 1)
var y4 = Yemek(name: "makarna", count: 3)
var y5 = Yemek(name: "ayran", count: 1)
var y6 = Yemek(name: "makarna", count: 2)

var sepet: [Yemek] = [y1, y2, y3, y4, y5, y6]

var uniqueSepet = Set<String>()

for yemek in sepet {
    uniqueSepet.insert(yemek.name)
}

var filteredArray = [Yemek]()

for uniqueName in uniqueSepet {
    let sameNames = sepet.filter {
        $0.name == uniqueName
    }
    
    var total = 0
    
    for yemek in sameNames {
        total += yemek.count
    }
    
    filteredArray.append(Yemek(name: uniqueName, count: total))
}

print(filteredArray)
