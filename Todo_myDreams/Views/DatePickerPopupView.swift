//
//  DatePickerPopupView.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/28.
//

import Foundation
import UIKit

class DatePickerPopupView: UIView {
    
    enum DateSelectionType {
        case start
        case end
        case none
    }
    
    // MARK: - Properties

    var currentSelection: DateSelectionType = .none

    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.tintColor = UIColor(red: 0.54, green: 0.49, blue: 0.22, alpha: 1.00)
        return picker
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("확인", for: .normal)
        button.tintColor = UIColor(red: 0.54, green: 0.49, blue: 0.22, alpha: 1.00)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.tintColor = UIColor(red: 0.54, green: 0.49, blue: 0.22, alpha: 1.00)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    var onSelectDate: ((Date) -> Void)?
    var onCancel: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.clipsToBounds = true
        
        contentView.addSubview(datePicker)
        contentView.addSubview(doneButton)
        contentView.addSubview(cancelButton)
        
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            contentView.widthAnchor.constraint(equalToConstant: 350),
            
            datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            doneButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Method & Action
    
    @objc private func handleDone() {
        onSelectDate?(datePicker.date)
        removeFromSuperview()
    }
    
    @objc private func handleCancel() {
        onCancel?()
        removeFromSuperview()
    }
}
