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
        
        if User.userTodo.isEmpty {
            let data1: Todo = Todo(goal: "test1", date: "test1", complete: true, memo: "test1")
            let data2: Todo = Todo(goal: "test2", date: "test2", complete: true, memo: "test2")
            let data3: Todo = Todo(goal: "test3", date: "test3", complete: false, memo: "test3")
            
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
        gotoListView.setTitle("Todo List Button", for: .normal)
        
        gotoCompletedView.setTitle("Todo List Button", for: .normal)
    }
}

