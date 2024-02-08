//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 2024/01/29.
//

import Foundation

//struct Bank {
//    private let bankManager: BankManager
//    private let customNum: Int
//    
//    init(customNum: Int, bankManager: BankManager) {
//            self.customNum = customNum
//            self.bankManager = bankManager
//        }
//    
//    func openBank() {
//        setCustomerCount(customer: customNum)
//        let workTime = calulateWorkTime {
//            do {
//                try bankManager.assignBank()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        closeBank(time: workTime)
//    }
//    
//    private func setCustomerCount(customer: Int) {
//        (1...customer).forEach { bankManager.standBy(customer: Customer(banking: Banking.allCases.randomElement(), numOfPerson: $0)) }
//    }
//    
//    private func calulateWorkTime(work: () -> Void) -> String {
//        let startTime = CFAbsoluteTimeGetCurrent()
//        work()
//        let endTime = CFAbsoluteTimeGetCurrent()
//        return String(format: "%.2f", endTime - startTime)
//    }
//    
//    private func closeBank(time: String) {
//        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customNum)명이며, 총 업무시간은 \(time)초 입니다.")
//    }
//}
