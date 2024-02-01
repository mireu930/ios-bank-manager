//
//  ConsoleManager.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 1/29/24.
//

import Foundation

struct ConsoleManager: CustomerNumbering {
    var banking: Banking?
    private let isBool: Bool = true
    var numOfPerson: Int { Int.random(in: 10...30) }
    
    private enum Message {
        static let menu = """
                          1 : 은행개점
                          2 : 종료
                          입력 :
                          """
        static let reselection = "메뉴를 다시 선택해주세요."
        static let first = "1"
        static let second = "2"
    }
    
    func startBank() {
        while isBool {
            print(Message.menu, terminator: " ")
            guard let input = readLine() else { return }
            
            switch input {
            case Message.first:
                Bank(customNum: numOfPerson, bankManager: BankManager(bankClerk: [.deposit: BankClerk(work: .deposit), .loan: BankClerk(work: .loan)])).openBank()
            case Message.second:
                return
            default:
                print(Message.reselection)
                continue
            }
        }
    }
}
