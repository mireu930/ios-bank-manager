//
//  Error.swift
//  BankManagerConsoleApp
//
//  Created by 미르, 희동 on 1/25/24.
//

import Foundation

enum QueueError: LocalizedError {
    case dequeueError
    
    var errorDescription: String? {
        switch self {
        case .dequeueError:
         return "값을 빼내지 못했습니다."
        }
    }
}
