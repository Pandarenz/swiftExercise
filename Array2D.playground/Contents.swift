//: Playground - noun: a place where people can play

import UIKit

var cookes = [[Int]]()
for j in 1...3 {
    var row = [Int]()
    for i in 1...6 {
        row.append(i+i*j)
    }
    cookes.append(row)
}

print(cookes)


print(cookes[2][5])

var cookies = [[Int]](repeating: [Int](repeating: 0, count: 7), count: 9)

var cook = [[Int]](repeatElement([Int](repeatElement(2, count: 9)), count: 9))

public struct Array2D<T> {
    public let columns: Int
    public let rows: Int
    fileprivate var array: [T]
    
    public init(columns: Int, rows: Int, initialValue: T) {
        self.columns = columns
        self.rows = rows
        array = .init(repeating: initialValue, count: rows*columns)
    }
    
    public subscript(column: Int, row: Int) -> T {
        get {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            return array[row*columns + column]
        }
        set {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            array[row*columns + column] = newValue
        }
    }
}

var cookis = Array2D(columns: 9, rows: 7, initialValue: 0)

//print(cookes)

