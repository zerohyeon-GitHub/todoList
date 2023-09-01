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
        print("ListViewController 실행")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        TodoList().initData()
        
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
        print("viewWillAppear")
        listTableView.reloadData()
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let addViewController = AddTodoViewController()
        let storyboardName = addViewController.storyboardName
        let storyboardID = addViewController.storyboardID
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main) // Main.stroyboard와 연동하는 작업 (변수에 담는 작업)
        guard let viewController = storyboard.instantiateViewController(identifier: storyboardID) as? AddTodoViewController else { return }
        
        viewController.completion = { // [weak self] in  // ARC
            self.listTableView.reloadData()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
//        present(viewController, animated: true)
        
        //        present(viewController, animated: true) { [weak self] in
        //            // dismiss가 되면 여기가 실행이 된다.
        //            self?.listTableView.reloadData()
        //        }
    }
    
    func setTitle() {
        let titleName = UILabel()
        titleName.text = "Todo List"
        titleName.font = UIFont.boldSystemFont(ofSize: 30)
        titleName.sizeToFit()

        navigationItem.titleView = titleName
//        navigationItem.title = "Todo List"
        
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
    
    // section 객수
    func numberOfSections(in tableView: UITableView) -> Int {
        //        print("TypeList.allCases.count : \(TypeList.allCases.count)")
        return TypeList.allCases.count
    }
    
    // tableView에 표시할 행의 수를 return - 셀 숫자
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var cellCount: [Int]
        var exerciseCount: Int = 0
        var studyCount: Int = 0
        var cookingCount: Int = 0
        
        // 곧 수정
        for i in 0..<DataManager.shared.load().count { // 총 전체 데이터 중에서
            switch DataManager.shared.load()[i].type {
            case TypeList.Exercise.rawValue:
                exerciseCount += 1
                break
            case TypeList.Study.rawValue:
                studyCount += 1
                break
            case TypeList.Cooking.rawValue:
                cookingCount += 1
                break
            default:
                print("numberOfRowsInSection : default")
            }
        }
        cellCount = [exerciseCount, studyCount, cookingCount]
        //        print("section: \(section)")
        //        print("cellCount: \(cellCount)")
        
        return cellCount[section]
    }
    
    // cell에 표시하기 위한 Cell을 만들어서 return 한다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell // 여기서 as의 역할은 무엇일까?
        
        var dataKey: Int
        var text: String
        var isCompleted: Bool
        
        // Section에 따라서 Cell 생성
        switch TodoList.listType[indexPath.section] {
        case TypeList.Exercise.rawValue:
            
            //            print("listExercise : \(TodoList.listExercise)")
            //            print("indexPath.row : \(indexPath.row)")
            //
            //            print("listExercise[indexPath.row].keys : \(TodoList.listExercise[indexPath.row].keys)")
            //            print("listExercise[indexPath.row].values : \(TodoList.listExercise[indexPath.row].values)")
            //            print("type : \(type(of: TodoList.listExercise[indexPath.row].values))")
            //            print("변경")
            
            //            print("listExercise[indexPath.row] : \(TodoList.listExercise[indexPath.row].map{$0}[0].key)")
            //            print("listExercise[indexPath.row] : \(TodoList.listExercise[indexPath.row].map{$0}[0].value.goal)")
            dataKey = TodoList.listExercise[indexPath.row].map{$0}[0].key
            text = TodoList.listExercise[indexPath.row].map{$0}[0].value.goal
            isCompleted = TodoList.listExercise[indexPath.row].map{$0}[0].value.iscompleted
            break
        case TypeList.Study.rawValue:
            dataKey = TodoList.listStudy[indexPath.row].map{$0}[0].key
            text = TodoList.listStudy[indexPath.row].map{$0}[0].value.goal
            isCompleted = TodoList.listStudy[indexPath.row].map{$0}[0].value.iscompleted
            break
        case TypeList.Cooking.rawValue:
            dataKey = TodoList.listCooking[indexPath.row].map{$0}[0].key
            text = TodoList.listCooking[indexPath.row].map{$0}[0].value.goal
            isCompleted = TodoList.listCooking[indexPath.row].map{$0}[0].value.iscompleted
            break
        default:
            print("cellForRowAt : default")
            dataKey = 0
            text = "default"
            isCompleted = false
        }
        
        // cell index 값을 확인하기 위해서
        cell.datakeyIndex = dataKey
        cell.cellSection = indexPath.section
        cell.cellIndex = indexPath.row
        
        cell.todoName.text = text
        
        cell.setStackView()
        cell.setLabel()
        cell.setSwich(state: isCompleted)
        
        return cell
    }
    
    // Section Header에 나타날 글자 선택
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionList: [String] = TypeList.allCases.map {
            $0.rawValue
        }
        return sectionList[section]
    }
    
    /* data 삭제하는 방법 중 하나
     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
     return .delete
     }
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     tableView.beginUpdates()
     
     //            User.userTodo.remove(at: indexPath.row)
     
     tableView.deleteRows(at: [indexPath], with: .fade)
     tableView.endUpdates()
     }
     }
     */
}

extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tab : \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, success) in
            
            var dataKey: Int
            
            // 데이터 삭제 시 section과 row 같이 확인
            switch TodoList.listType[indexPath.section] {
            case TypeList.Exercise.rawValue:
                dataKey = TodoList.listExercise[indexPath.row].map{$0}[0].key
                break
            case TypeList.Study.rawValue:
                dataKey = TodoList.listStudy[indexPath.row].map{$0}[0].key
                break
            case TypeList.Cooking.rawValue:
                dataKey = TodoList.listCooking[indexPath.row].map{$0}[0].key
                break
            default:
                print("trailingSwipeActionsConfigurationForRowAt : default")
                dataKey = 0
            }
            
            DataManager.shared.delete(index: dataKey)
            // 기존에 저장되어있던 데이터는 비우기
            TodoList().clear()
            // delete Data 완료한 후 새로 데이터 초기화
            TodoList().initData()
            
            tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = UIColor.red
        delete.title = "삭제"
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
