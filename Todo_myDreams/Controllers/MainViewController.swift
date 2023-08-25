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

    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var gotoListView: UIButton!
    @IBOutlet weak var gotoCompletedView: UIButton!
    @IBOutlet weak var gotoURLView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userdefault count : \(DataManager.shared.loadUsers().count)")
        for i in 0..<DataManager.shared.loadUsers().count {
            print("\(i) : \(DataManager.shared.loadUsers()[i])")
        }
        
        // 데이터가 없는 경우 임의로 넣어줌
        if DataManager.shared.loadUsers().isEmpty {
            let data1: DataTodo = DataTodo(type: "", goal: "스쿼트 200kg", date: "2023-12-20", iscompleted: false, memo: "현재 350lb")
            let data2: DataTodo = DataTodo(type: "", goal: "데드리프트 250kg", date: "2023-12-25", iscompleted: false, memo: "현재 420lb")
            let data3: DataTodo = DataTodo(type: "", goal: "벤치프레스 150kg", date: "2023-12-30", iscompleted: false, memo: "현재 100kg")
            
            DataManager.shared.save(todo: [data1, data2, data3])
            
            print("userDefault 데이터")
            print(DataManager.shared.loadUsers())
        }
        
        setLabel()
        setButton()
    }
    
    func setLabel() {
        appTitle.text = "Zero's DataTodo List"
        appTitle.font = UIFont.boldSystemFont(ofSize: 30)
        appTitle.sizeToFit()
        appTitle.textAlignment = .center
        
        appName.text = "Zero"
        appName.sizeToFit()
        appName.textAlignment = .center
    }
    
    func setButton() {
        // DataTodo List 이동
        gotoListView.setTitle("DataTodo List Button", for: .normal)
        gotoListView.setTitleColor(.black, for: .normal)
        
        gotoListView.tintColor = UIColor.green
        
        gotoListView.layer.cornerRadius = 10
        gotoListView.layer.borderWidth = 2
        gotoListView.layer.borderColor = UIColor.black.cgColor
        
        // Stack View spacing setting
        mainStackView.setCustomSpacing(30, after: gotoListView)
        
        // Completed DataTodo List 이동
        gotoCompletedView.setTitle("Completed DataTodo List Button", for: .normal)
        gotoCompletedView.setTitleColor(.black, for: .normal)
        
        gotoCompletedView.tintColor = UIColor.green
        
        gotoCompletedView.layer.cornerRadius = 10
        gotoCompletedView.layer.borderWidth = 2
        gotoCompletedView.layer.borderColor = UIColor.black.cgColor
        
        // Stack View spacing setting
        mainStackView.setCustomSpacing(30, after: gotoCompletedView)
        
        // URL Session 이동
        gotoURLView.setTitle("URL Button Button", for: .normal)
        gotoURLView.setTitleColor(.black, for: .normal)
        
        gotoURLView.tintColor = UIColor.green
        
        gotoURLView.layer.cornerRadius = 10
        gotoURLView.layer.borderWidth = 2
        gotoURLView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func moveURL(_ sender: Any) {
//        let urlViewController = HomeViewController(homeView: HomeView())
        let urlViewController = HomeViewController()

        self.navigationController?.pushViewController(urlViewController, animated: true)
        
//        let urlViewController = HomeViewController()
//        self.present(urlViewController, animated: true, completion: nil)
    }
    
}

