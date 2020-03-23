import UIKit

// Primitive Types

/// String
var name: String = "David Thorn"

/// Int
var age: Int = 41

/// Double
var half: Double = 0.5

/// Float
var floatHalf: Float = 0.5

/// Bool
var isOld: Bool = true

/// NULL
var holdNothing: Int? = nil

/// Array Int
var numbers = [ 1,2,3,4,5,6 ]

var emptyArrayOfNumbers = [Int]()

/// Maths

var itemOnePrice = 20.25

var itemTwoPrice = 6.99

var totalPrice = itemOnePrice + itemTwoPrice

var num1 = 1
var num2 = 4

var totalNum = num1 + num2

var num3 = 4
var dec1 = 2.3

var decNumTotal = Double(num3) + dec1

/// Functional programming language

/// Pure Functions

func add(_ num1: Int , _ num2: Int) -> Int {
    return num1 + num2
}

func substract(_ num1: Int , _ num2: Int) -> Int {
    return num1 - num2
}

var result = add(5,6)
substract(2, 4)

/// Impure Functions

var totalItems = [Int]()

func addItem(_ itemNumber: Int) -> Void {
    totalItems.append(itemNumber)
}

addItem(2)
addItem(6)
addItem(9)

print(totalItems)

/// Convert Impure function to pure function

func addItem(_ itemNumber: Int, items: [Int]) -> [Int] {
    var _items = items
    _items.append(itemNumber)
    return _items
}

var newItems = [Int]()

newItems = addItem(3, items: newItems)
newItems = addItem(5, items: newItems)
newItems = addItem(6, items: newItems)
newItems = addItem(2, items: newItems)

print(newItems)


var lambdaAdd: (Int, Int) -> Int = { (num1, num2) -> Int in
    return num1 + num2
}

lambdaAdd(3,5)

/// Classes

class Person {
    let name: String
    let age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let david = Person(name: "David", age: 41)
david.name
david.age

struct PersonStruct {
    let name: String
    let age: Int
}

let john = PersonStruct(name: "John", age: 32)






