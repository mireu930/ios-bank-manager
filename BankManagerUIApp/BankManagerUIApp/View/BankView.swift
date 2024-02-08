//
//  BankView.swift
//  BankManagerUIApp
//
//  Created by 미르, 희동 on 2/6/24.
//

import UIKit

class BankView: UIView {
    let addCustomerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("고객 10명 추가", for: .normal)
        button.tintColor = .blue
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("초기화", for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addCustomerButton, resetButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let taskTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "업무시간 - 00:00:000"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let waitLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor  = .white
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [waitLabel, taskLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonStackView, taskTimeLabel, labelStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var waitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var waitTableView: UITableView = {
        let tableView = UITableView()
        tableView.addSubview(waitStackView)
        
        return tableView
    }()
    
    lazy var taskStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var taskTableView: UITableView = {
        let tableView = UITableView()
        tableView.addSubview(taskStackView)
        
        return tableView
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [waitTableView, taskTableView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStackView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        self.addSubview(headerStackView)
        self.addSubview(footerStackView)
    }
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            footerStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor),
            footerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            footerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            footerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
