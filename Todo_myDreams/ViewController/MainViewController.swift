//
//  ViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var btnListView: UIButton!
    @IBOutlet weak var btnCompletedView: UIButton!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var gotoListView: UIButton!
    @IBOutlet weak var gotoCompletedView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터가 없는 경우 임의로 넣어줌
        if User.userTodo.isEmpty {
            let data1: Todo = Todo(goal: "스쿼트 200kg", date: "2023-12-20", complete: false, memo: "현재 350lb")
            let data2: Todo = Todo(goal: "데드리프트 250kg", date: "2023-12-25", complete: false, memo: "현재 420lb")
            let data3: Todo = Todo(goal: "벤치프레스 150kg", date: "2023-12-30", complete: false, memo: "현재 100kg")
            
            User().appendTodo(todo: data1)
            User().appendTodo(todo: data2)
            User().appendTodo(todo: data3)
        }
        
        setLabel()
        setButton()
    }
    
    func setLabel() {
        appTitle.text = "Zero's Todo List"
        appTitle.font = UIFont.boldSystemFont(ofSize: 30)
        appTitle.sizeToFit()
        appTitle.textAlignment = .center
        
        appName.text = "Zero"
        appName.sizeToFit()
        appName.textAlignment = .center
    }
    
    func setButton() {
        // Todo List 이동
        gotoListView.setTitle("Todo List Button", for: .normal)
        gotoListView.setTitleColor(.black, for: .normal)
        
        gotoListView.tintColor = UIColor.green
        
        gotoListView.layer.cornerRadius = 10
        gotoListView.layer.borderWidth = 2
        gotoListView.layer.borderColor = UIColor.black.cgColor
        
        // Stack View spacing setting
        mainStackView.setCustomSpacing(30, after: gotoListView)
        
        // Completed Todo List 이동
        gotoCompletedView.setTitle("Completed Todo List Button", for: .normal)
        gotoCompletedView.setTitleColor(.black, for: .normal)
        
        gotoCompletedView.tintColor = UIColor.green
        
        gotoCompletedView.layer.cornerRadius = 10
        gotoCompletedView.layer.borderWidth = 2
        gotoCompletedView.layer.borderColor = UIColor.black.cgColor
    }
}

