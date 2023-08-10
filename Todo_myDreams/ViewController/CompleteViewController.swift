//
//  CompleteViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var completeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeTableView.dataSource = self
        completeTableView.delegate = self
        
        completeTableView.separatorInset.left = 0
    }
}

// UITableViewDelegate = TableView의 시각적인 부분을 설정하고, 행의 액션 관리, 액세서리 뷰 지원 그리고 테이블 뷰의 개별행 편집을 도와준다.
// UITableVeiwSource = TableView를 생성하고 수정하는데 필요한 정보를 TableView 객체에 제공한다.

extension CompleteViewController: UITableViewDataSource {
    // tableView에 표시할 행의 수를 return
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        
        for i in 0..<User.userTodo.count {
            if User.userTodo[i].complete {
                cellCount += 1
            }
        }
        
        return cellCount
    }
    
    // cell에 표시하기 위한 Cell을 만들어서 return 한다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = completeTableView.dequeueReusableCell(withIdentifier: "completeCell", for: indexPath) as! CompleteTableViewCell // 여기서 as의 역할은 무엇일까?
        
        if User.userTodo[indexPath.row].complete {
            cell.todoName.text = User.userTodo[indexPath.row].goal
            cell.todoDate.text = User.userTodo[indexPath.row].date
        }
        
        cell.setStackView()
        cell.setLabel()
        
        return cell
    }
}

extension CompleteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tab : \(indexPath)")
        showPopUp(title: User.userTodo[indexPath.row].goal, message: User.userTodo[indexPath.row].date)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
}
