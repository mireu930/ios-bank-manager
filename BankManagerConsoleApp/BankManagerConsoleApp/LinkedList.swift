//
//  File.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 1/24/24.
//

import Foundation

final class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    init(head: Node<T>? = nil, tail: Node<T>? = nil) {
        self.head = head
        self.tail = tail
    }
    
    func append(value: T) {
        let newNode = Node(data: value)
        
        if head == nil {
            head = newNode
        } else {
            tail?.next = newNode
        }
        tail = newNode
    }
    
    func removeFirst() -> T? {
        guard let headData = head?.data else { return nil }
        head = head?.next

        return headData
    }
    
    func peek() -> T? {
        head?.data
    }
    
    func isEmpty() -> Bool {
        head == nil
    }
    
    func clear() {
        head = nil
        tail = nil
    }
}
