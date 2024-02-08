//
//  CustomerLabel.swift
//  BankManagerUIApp
//
//  Created by 미르, 희동 on 2/6/24.
//

import UIKit

class CustomerLabel: UILabel {
    var customer: Customer
    
    init(customer: Customer) {
        self.customer = customer
        super.init(frame: .zero)
        self.viewLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewLabel() {
        self.text = "\(customer.numOfPerson)번 - \(customer.banking?.rawValue ?? "")"
        
        switch customer.banking {
        case .deposit:
            self.textColor = .black
        case .loan:
            self.textColor = .purple
        case .none:
            return
        }
    }
    
}
