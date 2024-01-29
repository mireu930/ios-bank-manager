//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 2024/01/29.
//

import Foundation

protocol Number {
    var numOfPerson: Int { get }
}

struct Customer: Number {
    var numOfPerson: Int
    
}
