//
//  SwiftListNodeViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2022/6/10.
//

import UIKit

class SwiftListNodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        testSingleLinkedList()
        testDoubleLinkedList()
    }

    /// 测试单向链表
    func testSingleLinkedList() {
        let list = SwiftSinglyLinkedList<Int>()

        list.append(11)
        list.append(22)
        list.append(33)
        list.append(44)

        list[0] = 55 // [55, 11, 22, 33, 44]
        list[2] = 66 // [55, 11, 66, 22, 33, 44]
        list[list.count] = 77 // [55, 11, 66, 22, 33, 44, 77]

        _ = list.remove(0) // [11, 66, 22, 33, 44, 77]
        _ = list.remove(2) // [11, 66, 33, 44, 77]
        _ = list.remove(list.count - 1) // [11, 66, 33, 44]

        assert(list.indexOf(44) == 3)
        assert(list.indexOf(22) == nil)
        assert(list.contains(33))
        assert(list[0] == 11)
        assert(list[1] == 66)
        assert(list[list.count - 1] == 44)

        print(list.description)
    }

    /// 测试双向链表
    func testDoubleLinkedList() {
        let list = SwiftDoublyLinkedList<Int>()

        list.append(11)
        list.append(22)
        list.append(33)
        list.append(44)

        list[0] = 55 // [55, 11, 22, 33, 44]
        list[2] = 66 // [55, 11, 66, 22, 33, 44]
        list[list.count] = 77 // [55, 11, 66, 22, 33, 44, 77]

        _ = list.remove(0) // [11, 66, 22, 33, 44, 77]
        _ = list.remove(2) // [11, 66, 33, 44, 77]
        _ = list.remove(list.count - 1) // [11, 66, 33, 44]

        assert(list.indexOf(44) == 3)
        assert(list.indexOf(22) == nil)
        assert(list.contains(33))
        assert(list[0] == 11)
        assert(list[1] == 66)
        assert(list[list.count - 1] == 44)

        print(list.description)
    }
}
