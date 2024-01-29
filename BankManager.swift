//
//  BankManager.swift
//  Created by yagom.
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
            BankClerk().recieve(customer: list as! Customer )
        }
    }
}
