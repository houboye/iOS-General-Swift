//
//  SwfitLinkedListProtocol.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/6/10.
//

import Foundation

public protocol SwfitLinkedListProtocol {
    associatedtype E: Equatable
    
    /// description string when you want debug
    var description: String { get }
    
    /// the linked list count
    var count: Int { get }
    
    /// is linked list has element
    /// - Returns: is linked list empty
    var isEmpty: Bool { get }
    
    subscript(index: Int) -> E? { get set }
    
    /// remove all element
    func removeAll()
    
    /// is linked list contains some element
    /// - Parameter element: target element
    /// - Returns: is linked list has the element
    func contains(_ element: E) -> Bool
    
    /// add a element on linked list tail
    /// - Parameter element: target element
    func append(_ element: E)
    
    /// set a new element to some index
    /// - Parameters:
    ///   - index: target index
    ///   - element: new element
    /// - Returns: old element at the index
    func set(_ index: Int, element: E) -> E?
    
    /// remove an element at index
    /// - Parameter index: target index
    /// - Returns: the element you removed
    func remove(_ index: Int) -> E?
    
    /// get the element index
    /// - Parameter element: target element
    /// - Returns: element‘s location
    func indexOf(_ element: E) -> Int?
}

public extension SwfitLinkedListProtocol {
    var isEmpty: Bool {
        return count == 0
    }
}
