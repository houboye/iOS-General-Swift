//
//  SinglyLinkedList.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/6/10.
//

import Foundation

public class SwiftSinglyLinkedList<E> where E: Equatable {
    private class Node<E> {
        var element: E
        var next: Node<E>?
        init(element: E, next: Node<E>?) {
            self.element = element
            self.next = next
        }
    }

    /// linked list size
    private var size: Int = 0
    /// first node
    private var first: Node<E>?

    private func node(_ index: Int) -> Node<E>? {
        SwiftLinkedListUtils.indexValidCheck(index, size: size)

        var node = first

        (0..<index).forEach { _ in
            node = node?.next
        }

        return node
    }
}

extension SwiftSinglyLinkedList: SwfitLinkedListProtocol {
    public typealias E = E

    public var description: String {
        var desc = "size -> \(size), ["
        var tempNode = first

        (0..<size).forEach {
            if $0 != 0 { desc += ", " }
            desc += "\(String(describing: tempNode?.element ?? nil))"
            tempNode = tempNode?.next
        }

        desc += "]"

        return desc
    }

    public var count: Int {
        return size
    }

    public subscript(index: Int) -> E? {
        get {
            return node(index)?.element
        }

        set {
            SwiftLinkedListUtils.indexValidCheckForAdd(index, size: size)

            guard let element = newValue else {
                assert(false, "Can not set a nil into linkedList!")
                return
            }

            // index 为 0 时需特殊处理
            if index == 0 {
                first = Node(element: element, next: first)
            } else {
                let prevNode = node(index - 1)
                prevNode?.next = Node(element: element, next: prevNode?.next)
            }

            size += 1
        }
    }

    public func contains(_ element: E) -> Bool {
        if indexOf(element) != nil {
            return true
        }
        return false
    }

    public func append(_ element: E) {
        self[size] = element
    }

    public func set(_ index: Int, element: E) -> E? {
        let originNode = node(index)
        let originElement = originNode?.element
        originNode?.element = element
        return originElement
    }

    public func remove(_ index: Int) -> E? {
        SwiftLinkedListUtils.indexValidCheck(index, size: size)

        var tempNode = first

        if index == 0 {
            first = tempNode?.next
        } else {
            let prevNode = node(index - 1)

            tempNode = prevNode?.next
            prevNode?.next = tempNode?.next
        }

        size -= 1

        return tempNode?.element
    }

    public func indexOf(_ element: E) -> Int? {
        var tempNode = first

        for i in 0..<size {
            if element == tempNode?.element { return i }

            tempNode = tempNode?.next
        }

        return nil
    }

    public func removeAll() {
        size = 0
        first = nil
    }
}
