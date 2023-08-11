//
//  ListViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class ListViewController: UIViewController {

    
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var addBtn: UIButton!
    
    deinit{
        print("listview")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle() // navigation title 설정
        setCurrentTime()// 현재 날짜 표시
        setButton() // 데이터 추가 버튼
        
        listTableView.dataSource = self
        listTableView.delegate = self
        
        listTableView.separatorInset.left = 0
//        listTableView.contentMode = .scaleAspectFill
    }
    
    // full screen일 때만 실행됨.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listTableView.reloadData()
    }

    @IBAction func addTodo(_ sender: Any) {
        let addViewController = addListPopup()
        let storyboardName = addViewController.storyboardName
        let storyboardID = addViewController.storyboardID
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main) // Main.stroyboard와 연동하는 작업 (변수에 담는 작업)
        guard let viewController = storyboard.instantiateViewController(identifier: storyboardID) as? addListPopup else { return }
        
        viewController.completion = { // [weak self] in  // ARC
            self.listTableView.reloadData()
        }
        
        present(viewController, animated: true)
        
//        present(viewController, animated: true) { [weak self] in
//            // dismiss가 되면 여기가 실행이 된다.
//            self?.listTableView.reloadData()
//        }
    }
    
    func setTitle() {
        let titleName = UILabel()
        titleName.text = "Todo List"
        titleName.font = UIFont.boldSystemFont(ofSize: 20)
        titleName.sizeToFit()
         
        navigationItem.titleView = titleName
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func setCurrentTime() {
        // 현재 날짜
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: Date())
        
        currentTime.text = currentDate
    }
    
    func setButton() {
        addBtn.setTitle("add Todo", for: .normal)
        addBtn.setTitleColor(.black, for: .normal)
        
        addBtn.tintColor = UIColor.green
        
        addBtn.layer.cornerRadius = 10
        addBtn.layer.borderWidth = 2
        addBtn.layer.borderColor = UIColor.black.cgColor
    }
}

extension ListViewController: UITableViewDataSource {
    // tableView에 표시할 행의 수를 return
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return User.userTodo.count
    }
    
    // cell에 표시하기 위한 Cell을 만들어서 return 한다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell // 여기서 as의 역할은 무엇일까?
        
        // cell index 값을 확인하기 위해서
        cell.cellIndex = indexPath.row
        
        cell.todoName.text = User.userTodo[indexPath.row].goal
        
        cell.setStackView()
        cell.setLabel()
        cell.setSwich()
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tab : \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
