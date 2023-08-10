//
//  showCompleteInfo.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/10.
//

import Foundation
import UIKit

class showCompleteInfo: UIViewController {
    private var goalText: String?
    private var dateText: String?
    private var memoText: String?
    
    // title
    private lazy var infoTitle: UILabel = {
        let label = UILabel()
        label.text = "Completed Todo List"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    // name
    private lazy var goalTitle: UILabel = {
        let label = UILabel()
        label.text = "Completed Todo List"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    // date
    private lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.text = "Completed Todo List"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    // memo
    private lazy var memoTitle: UILabel = {
        let label = UILabel()
        label.text = "Completed Todo List"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
}
