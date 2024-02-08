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
    
    func search(index: Int) -> Node<T>? {
        if index == 0 {
           return head
        } else {
            var node = head?.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            
            return node
        }
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
    
    func insertNode(index: Int, from data: T) {
        let newNode = Node(data: data)
        
        if head == nil {
            head = newNode
            tail = newNode
        }
        guard let frontNode = search(index: index - 1) else {
            tail?.next = newNode
            tail = newNode
            return
        }
        
        guard let nextNode = frontNode.next else {
            frontNode.next = newNode
            tail = newNode
            return
        }
        
        newNode.next = nextNode
        frontNode.next = newNode
    }
    
    func removeFirst() -> T? {
        guard let headData = head?.data else { return nil }
        head = head?.next

        return headData
    }
    
    func remove(index: Int) -> T? {
        if index == 0 {
            return removeFirst()
        }
        
        guard let frontNode = search(index: index - 1) else {
            return nil
        }
            
        guard let removeNode = frontNode.next else {
            return nil
        }
            
        guard let nextNode = removeNode.next else {
            frontNode.next = nil
            tail = frontNode
            return removeNode.data
        }
            
        frontNode.next = nextNode
            
        return removeNode.data
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
