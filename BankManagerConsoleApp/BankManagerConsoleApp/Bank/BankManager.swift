//
//  BankManager.swift
//  Created by 미르, 희동.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    private let queue = Queue<CustomerNumbering>(queue: LinkedList<CustomerNumbering>())
    private let bankClerk: [Banking: BankClerk]
    
    init(bankClerk: [Banking : BankClerk]) {
        self.bankClerk = bankClerk
    }
    
    func standBy(customer: CustomerNumbering) {
        queue.enqueue(element: customer)
    }
    
    func assign() throws {
        let dispatchgroup = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 2)
        let loanQueue = DispatchQueue(label: "loanQueue")
        let depositQueue = DispatchQueue(label: "depositQueue", attributes: .concurrent)
        
        while let list = try? queue.dequeue(), let banking = list.banking {
            guard let customer = list as? Customer else {
                throw QueueError.dequeueError
            }
            switch banking {
                case .deposit:
                    depositQueue.async(group: dispatchgroup) {
                        semaphore.wait()
                        bankClerk[.deposit]?.recieve(customer: customer)
                        semaphore.signal()
                    }
                    
                case .loan:
                    loanQueue.async(group: dispatchgroup) {
                        bankClerk[.loan]?.recieve(customer: customer)
                    }
                }
            }
        dispatchgroup.wait()
    }
}
