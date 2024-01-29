//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 2024/01/29.
//

import Foundation

struct Bank {
    let bankManager = BankManager()
    let bankClerk = BankClerk()
    let customNum: Int
    
    init(customNum: Int) {
        self.customNum = customNum
    }
    
    func openBank() {
        setCustomerCount(customer: customNum)
        let startWorkTime: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
        bankManager.assign()
        let endOfWorkTime: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
        let workTime = String(format: "%.2f", endOfWorkTime - startWorkTime)
        closeBank(time: workTime)
    }
    
    func setCustomerCount(customer: Int) {
        (1...customer).forEach { bankManager.standBy(customer: Customer(numOfPerson: $0)) }
    }
    
    func closeBank(time: String) {
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customNum)명이며, 총 업무시간은 \(time)초 입니다.")
    }
}
