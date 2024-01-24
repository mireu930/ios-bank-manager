//
//  Node.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 2024/01/24.
//

import Foundation

final class Node<T> {
    let data: T
    var next: Node?
    
    init(data: T, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}
