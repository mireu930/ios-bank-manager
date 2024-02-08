//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import UIKit

protocol ManageLabel: AnyObject {
    func turn(cusomer: Customer)
    func quit(cusomer: Customer)
}

class ViewController: UIViewController {
    
    private let bankView = BankView()
    private var timer: Timer?
    private var initialTime = 0.000
    private var bankManager =  BankManager()
    private var count = 1
    private let dispatchGroup = DispatchGroup()
    private var isRunning = false
    
    override func loadView() {
        view = bankView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bankView.addCustomerButton.addTarget(self, action: #selector(addCustomerButtonTapped), for: .touchUpInside)
        bankView.resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc func addCustomerButtonTapped() {
        for num in count...count + 9 {
            let customer = Customer(banking: Banking.allCases.randomElement(), numOfPerson: num)
            bankManager.standBy(customer: customer)
            bankView.waitStackView.addArrangedSubview(CustomerLabel(customer: customer))
        }
        
        count += 10
        
        bankManager.delegate = self
        do {
            try bankManager.assignBank(dispatchGroup: dispatchGroup)
        } catch {
            print(error)
        }
        guard isRunning == false else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(runningTimer), userInfo: nil, repeats: true)
        
        guard let timer = timer else { return }
        RunLoop.main.add(timer, forMode: .common)
        isRunning = true
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.timer?.invalidate()
            self.isRunning = false
        }
    }
    
    @objc func resetButtonTapped() {
        bankManager.stop()
        
        for subView in bankView.waitStackView.arrangedSubviews {
            subView.removeFromSuperview()
        }
        for subeView in bankView.taskStackView.arrangedSubviews {
            subeView.removeFromSuperview()
        }
        
        timer?.invalidate()
        timer = nil
        initialTime = 0.000
        bankView.taskTimeLabel.text = "업무시간 - 00:00:000"
        
        count = 1
    }
    
    @objc func runningTimer() {
        let minutes = Int(initialTime) / 60
        let seconds = Int(initialTime) % 60
        let milliSeconds = Int((initialTime.truncatingRemainder(dividingBy: 1)) * 1000)
        
        bankView.taskTimeLabel.text = String(format: "업무시간 - %02d:%02d:%03d", minutes, seconds, milliSeconds)
        initialTime += 0.001
    }
}

extension ViewController: ManageLabel {
    
    func turn(cusomer: Customer) {
        DispatchQueue.main.async {
            let cusomerLabel = self.bankView.waitStackView.arrangedSubviews.first { view in
                guard let cusomerLabelNumber = view as? CustomerLabel else { return  false }
                return cusomerLabelNumber.customer.numOfPerson == cusomer.numOfPerson
            }
            cusomerLabel?.removeFromSuperview()
            self.bankView.taskStackView.addArrangedSubview(CustomerLabel(customer: cusomer))
        }
    }
    
    func quit(cusomer: Customer) {
        DispatchQueue.main.async {
            let customerLabel = self.bankView.taskStackView.arrangedSubviews.first { view in
                guard let cusomerLabelNumber = view as? CustomerLabel else { return false }
                return cusomerLabelNumber.customer.numOfPerson == cusomer.numOfPerson
            }
            customerLabel?.removeFromSuperview()
        }
    }
}

