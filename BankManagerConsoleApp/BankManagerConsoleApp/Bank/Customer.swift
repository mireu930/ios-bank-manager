//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 2024/01/29.
//

import Foundation

protocol CustomerNumbering {
    var numOfPerson: Int { get }
    var banking: Banking? { get }
}

struct Customer: CustomerNumbering {
    let banking: Banking?
    private(set) var numOfPerson: Int
}
