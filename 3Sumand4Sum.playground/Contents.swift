//: Playground - noun: a place where people can play

import UIKit

let numbers = [1, 2, 3, 4, 5,0,-1,9292,-348]
    print(numbers.suffix(2))
     // Prints "[4, 5]"
     print(numbers.suffix(10))
     // Prints "[1, 2, 3, 4, 5]"

print(numbers.prefix(2))

extension Collection where Element: Equatable {
    
    /// In a sorted collection, replaces the given index with a successor mapping to a unique element.
    ///
    /// - Parameter index: A valid index of the collection. `index` must be less than `endIndex`
    func formUniqueIndex(after index: inout Index) {
        var prev = index
        repeat {
            prev = index
            formIndex(after: &index)
        } while index < endIndex && self[prev] == self[index]
    }
}
 
