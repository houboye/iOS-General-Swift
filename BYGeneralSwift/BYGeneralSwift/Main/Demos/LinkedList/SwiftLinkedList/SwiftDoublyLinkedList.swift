//
//  DoublyLinkedList.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/6/10.
//

import Foundation

class SwiftDoublyLinkedList<E> where E: Equatable {
    private class Node<E> {
        weak var prev: Node<E>?
        var element: E
        var next: Node<E>?
        
        /// 简述(debug 用)
        var description: String {
            var desc = ""
            
            desc += "\(String(describing: prev?.element ?? nil))"
            desc += "_\(String(describing: element))_"
            desc += "\(String(describing: next?.element ?? nil))"
            
            return desc
        }
        
        init(prev: Node<E>?, element: E, next: Node<E>?) {
            self.prev    = prev
            self.element = element
            self.next    = next
        }
    }
    
    /// linked list size
    private var size: Int = 0
    /// first node
    private var first: Node<E>?
    /// last node
    private var last: Node<E>?
    
    private func node(_ index: Int) -> Node<E>? {
        SwiftLinkedListUtils.indexValidCheck(index, size: size)
        
        // 二分法
        if (index < (size >> 1)) {
            var node = first
            
            (0..<index).forEach { _ in
                node = node?.next
            }
            
            return node
        } else {
            var node = last
            
            (index..<size - 1).forEach { _ in
                node = node?.prev
            }
            
            return node
        }
    }
}

extension SwiftDoublyLinkedList: SwfitLinkedListProtocol {
    typealias E = E
    
    var description: String {
        var desc = "size -> \(size), ["
        
        var tempNode = first

        (0..<size).forEach {
            if $0 != 0 { desc += ", " }

            desc += tempNode?.description ?? ""

            tempNode = tempNode?.next
        }

        desc += "]"

        return desc
    }
    
    var count: Int {
        return size
    }
    
    subscript(index: Int) -> E? {
        get {
            return node(index)?.element
        }
        set {
            SwiftLinkedListUtils.indexValidCheckForAdd(index, size: size)
            
            guard let element = newValue else {
                assert(false, "Can not set a nil into linkedList!")
                return
            }
            
            // 当往最后添加时
            if index == size {
                let oldLast = last
                last = Node(prev: oldLast, element: element, next: nil)
                
                if let _ = oldLast {
                    oldLast?.next = last
                } else {
                    first = last
                }
            } else { // 其他场景
                let next = node(index)
                let prev = next?.prev
                let current = Node(prev: prev, element: element, next: next)
                next?.prev = current
                
                // 当index 为 0时
                if let _ = prev {
                    prev?.next = current
                } else {
                    first = current
                }
            }
            
            size += 1
        }
    }
    
    func removeAll() {
        size  = 0
        first = nil
        last  = nil
    }
    
    func contains(_ element: E) -> Bool {
        if let _ = indexOf(element) {
            return true
        }
        return false
    }
    
    public func append(_ element: E) {
        self[size] = element
    }
    
    func set(_ index: Int, element: E) -> E? {
        let currentNode = node(index)
        let oldElemet = currentNode?.element
        currentNode?.element = element
        
        return oldElemet
    }
    
    func remove(_ index: Int) -> E? {
        SwiftLinkedListUtils.indexValidCheck(index, size: size)
        
        let current = node(index)
        let prev = current?.prev
        let next = current?.next
        
        // inde为0时
        if let _ = prev {
            prev?.next = next
        } else {
            first = next
        }
        
        // index为size - 1时
        if let _ = next {
            next?.prev = prev
        } else {
            last = prev
        }
        
        size -= 1
        return current?.element
    }
    
    func indexOf(_ element: E) -> Int? {
        var tempNode = first
        for i in 0..<size {
            if element == tempNode?.element { return i }
            
            tempNode = tempNode?.next
        }
        
        return nil
    }
}
