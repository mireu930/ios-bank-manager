//
//  BankManager.swift
//  Created by 미르, 희동.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    private let queue = Queue<CustomerNumbering>(queue: LinkedList<CustomerNumbering>())
    private let semaphore = DispatchSemaphore(value: 2)
    private let semaphore2 = DispatchSemaphore(value: 1)
    private let dispatchQueue = DispatchQueue.global(qos: .utility)
    weak var delegate: ManageLabel?
    
    func standBy(customer: CustomerNumbering) {
        queue.enqueue(element: customer)
    }
    
    func stop() {
        queue.clear()
    }
    
    func assignBank(dispatchGroup: DispatchGroup) throws {
        while let list = try? queue.dequeue(), let banking = list.banking {
            guard let customer = list as? Customer else {
                throw QueueError.dequeueError
            }
            switch banking {
                case .deposit:
                assignDeposit(customer: customer, dispatchGroup: dispatchGroup)
                case .loan:
                assignLoan(customer: customer, dispatchGroup: dispatchGroup)
                }
            }
    }
    
    func assignDeposit(customer: Customer, dispatchGroup: DispatchGroup) {
        dispatchQueue.async(group: dispatchGroup) {
            semaphore.wait()
            recieve(customer: customer)
            semaphore.signal()
        }
    }
    
    func assignLoan(customer: Customer, dispatchGroup: DispatchGroup) {
        dispatchQueue.async(group: dispatchGroup) {
            semaphore2.wait()
            recieve(customer: customer)
            semaphore2.signal()
        }
    }
    
    func recieve(customer: Customer) {
        delegate?.turn(cusomer: customer)
        paceTime(customer.banking?.pace ?? 0)
        delegate?.quit(cusomer: customer)
    }
    
    private func paceTime(_ pace: Double) {
        usleep(useconds_t(pace * 1000000))
    }
}
