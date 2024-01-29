//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 1/29/24.
//

import Foundation

struct BankClerk {
    var pace: Double = 0.7
    
    func recieve(customer: Customer) {
        print("\(customer.numOfPerson)번 고객 업무 시작")
        usleep(useconds_t(pace * 1000000))
        print("\(customer.numOfPerson)번 고객 업무 완료")
    }
}
