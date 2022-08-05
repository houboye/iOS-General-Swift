//
//  SwiftLinkedListUtils.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/6/10.
//

import UIKit

struct SwiftLinkedListUtils {

    /// LinkedList out of bounds
    /// - Parameters:
    ///   - index: index
    ///   - size: linked list count
    private static func outOfBounds(_ index: Int, size: Int) {
        assert(false, "SwiftLinkedList out of bounds：index --> \(index), size --> \(size)")
    }

    /// check index valid
    /// - Parameters:
    ///   - index: index
    ///   - size: linked list count
    public static func indexValidCheck(_ index: Int, size: Int) {
        if index < 0 || index >= size {
            outOfBounds(index, size: size)
        }
    }

    /// check add index valid
    /// - Parameters:
    ///   - index: index
    ///   - size: linked list count
    public static func indexValidCheckForAdd(_ index: Int, size: Int) {
        if index < 0 || index > size {
            outOfBounds(index, size: size)
        }
    }

}
