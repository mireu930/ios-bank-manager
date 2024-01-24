//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 2024/01/24.
//

import Foundation

struct Queue<T> {
    private var queue: LinkedList<T>
    
    init(queue: LinkedList<T>) {
        self.queue = queue
    }
    
    func enqueue(element: T) {
        queue.append(value: element)
    }
    
    func dequeue() -> T? {
        queue.removeFirst()
    }
    
    func isEmpty() -> Bool {
        queue.isEmpty()
    }
    
    func peek() -> T? {
        queue.peek()
    }
    
    func clear() {
        queue.clear()
    }
}
