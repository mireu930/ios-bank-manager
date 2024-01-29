//
//  BankManager.swift
//  Created by 미르, 희동.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    let queue = Queue<Number>(queue: LinkedList<Number>())
    
    func standBy(customer: Number) {
        queue.enqueue(element: customer)
    }
    
    func assign() {
        while let list = try? queue.dequeue() {
            BankClerk().recieve(customer: list as? Customer ?? Customer(numOfPerson: 0) )
        }
    }
}
