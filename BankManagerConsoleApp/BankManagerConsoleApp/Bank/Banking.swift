//
//  Banking.swift
//  BankManagerConsoleApp
//
//  Created by 미르 희동 on 2024/02/01.
//

import Foundation

enum Banking: String, CaseIterable {
    case deposit = "예금"
    case loan = "대출"
    
    var pace: Double {
        switch self {
        case .deposit:
           return 0.7
        case .loan:
           return 1.1
        }
    }
}
