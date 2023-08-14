//
//  CompleteViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var searchData: UILabel!
    @IBOutlet weak var completeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        setLabel()
        
        completeTableView.dataSource = self
        completeTableView.delegate = self
        
        completeTableView.separatorInset.left = 0
    }
    
    func setTitle() {
        let titleName = UILabel()
        titleName.text = "Competed Todo List"
        titleName.font = UIFont.boldSystemFont(ofSize: 20)
        titleName.sizeToFit()
        
        navigationItem.titleView = titleName
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func setLabel(){
        searchData.text = "Search data"
        searchData.textAlignment = .left
        searchData.font = .systemFont(ofSize: 15.0, weight: .bold)
        searchData.numberOfLines = 0
        searchData.textColor = .black
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
        
//        guard let sections = cellCount else {
//            tableView.setEmptyView(title: "Saved Tweets and Notes will show up here.",
//                                   message: "Tap the + button to get started.")
//            return 0
//        }
//        let sectionInfo = sections[section]
        
        if cellCount == 0 {
            tableView.setEmptyView(title: "완료된 Todo List가 없습니다.",
                                   message: "Todo List 목록에서 완료하세요.")
        } else {
            tableView.restore()
        }
        return cellCount
    }
    
    // cell에 표시하기 위한 Cell을 만들어서 return 한다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = completeTableView.dequeueReusableCell(withIdentifier: "completeCell", for: indexPath) as! CompleteTableViewCell // 여기서 as의 역할은 무엇일까?
        
        var completedTodo: [Int] = []
        
        for i in 0..<User.userTodo.count {
            if User.userTodo[i].complete {
                completedTodo.append(i)
            }
        }
        
        if User.userTodo[completedTodo[indexPath.row]].complete {
            cell.todoName.text = User.userTodo[completedTodo[indexPath.row]].goal
            cell.todoDate.text = User.userTodo[completedTodo[indexPath.row]].date
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .secondaryLabel
        messageLabel.font = .systemFont(ofSize: 17, weight: .medium)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
//            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 200),
            titleLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20)
        ])
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
