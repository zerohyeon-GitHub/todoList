//
//  TodoEditView.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/31.
//

import Foundation
import UIKit

class TodoEditView: UIView {
    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List Edit"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var nameStack: UIStackView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        let stack = UIStackView(arrangedSubviews: [typeLabel, typeTextField, separator])
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List Edit"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private let typeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        return textField
    }()
    
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List Edit"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    private let goalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        return textField
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List Edit"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        return textField
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.text = "Todo List Edit"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

    }
    
}
