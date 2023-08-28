//
//  ListViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class ListViewController: UIViewController {
    
    // UserDefaults 데이터를 미리 선언하기 위해 - Type 별로 구분 (Dictionary 사용 - UserDefault의 index를 알기 위해서)
    var listExercise: Array<Dictionary<Int, DataTodo>> = []
    var listStudy: Array<Dictionary<Int, DataTodo>> = []
    var listCooking: Array<Dictionary<Int, DataTodo>> = []
    
    var listType: [String] = []
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    deinit{
        print("ListViewController 실행")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        
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
    
    // UserDefault 데이터 초기화
    func initData() {
        for i in 0..<DataManager.shared.load().count {
            switch DataManager.shared.load()[i].type {
            case TypeList.Exercise.rawValue:
                listExercise.append([i : DataManager.shared.load()[i]])
            case TypeList.Study.rawValue:
                listStudy.append([i : DataManager.shared.load()[i]])
            case TypeList.Cooking.rawValue:
                listCooking.append([i : DataManager.shared.load()[i]])
            default:
                print("default")
            }
        }
        print("listExercise : \(listExercise)")
        print("listExercise : \(listStudy)")
        print("listExercise : \(listCooking)")
        
        listType = TypeList.allCases.map {
            $0.rawValue
        }
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let addViewController = AddListPopup()
        let storyboardName = addViewController.storyboardName
        let storyboardID = addViewController.storyboardID
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main) // Main.stroyboard와 연동하는 작업 (변수에 담는 작업)
        guard let viewController = storyboard.instantiateViewController(identifier: storyboardID) as? AddListPopup else { return }
        
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
        
        self.navigationController?.navigationBar.tintColor = .blue
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
        print("TypeList.allCases.count : \(TypeList.allCases.count)")
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
                print("default")
            }
        }
        cellCount = [exerciseCount, studyCount, cookingCount]
        print("section: \(section)")
        print("cellCount: \(cellCount)")
        
        return cellCount[section]
    }
    
    // cell에 표시하기 위한 Cell을 만들어서 return 한다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell // 여기서 as의 역할은 무엇일까?
        
        var dataKey: Int
        var text: String
        var isCompleted: Bool
        
        // Section에 따라서 Cell 생성
        switch listType[indexPath.section] {
        case TypeList.Exercise.rawValue:
            //            print("listExercise[indexPath.row] : \(listExercise[indexPath.row])")
            //            print("listExercise[indexPath.row] : \(listExercise[indexPath.row].values)")
            //            print("type : \(type(of: listExercise[indexPath.row].values))")
            //            print("변경")
            //            print("listExercise[indexPath.row] : \(listExercise[indexPath.row].map{$0}[0].value.goal)")
            dataKey = listExercise[indexPath.row].map{$0}[0].key
            text = listExercise[indexPath.row].map{$0}[0].value.goal
            isCompleted = listExercise[indexPath.row].map{$0}[0].value.iscompleted
            break
        case TypeList.Study.rawValue:
            dataKey = listStudy[indexPath.row].map{$0}[0].key
            text = listStudy[indexPath.row].map{$0}[0].value.goal
            isCompleted = listStudy[indexPath.row].map{$0}[0].value.iscompleted
            break
        case TypeList.Cooking.rawValue:
            dataKey = listCooking[indexPath.row].map{$0}[0].key
//            print("listCooking[indexPath.row] : \(listCooking[indexPath.row])")
//            print("listCooking[indexPath.row] : \(listCooking[indexPath.row].keys)")
//            print("listCooking[indexPath.row] : \(listCooking[indexPath.row].map{$0}[0].key)")
//            print("listCooking[indexPath.row] : \(listCooking[indexPath.row].values)")
//            print("listCooking[indexPath.row] : \(type(of: listCooking[indexPath.row].values))")
//            print("listCooking[indexPath.row] : \(type(of: listCooking[indexPath.row].map{$0}[0]))")
//            print("listCooking[indexPath.row] : \(type(of: listCooking[indexPath.row].map{$0}[0].value))")
            text = listCooking[indexPath.row].map{$0}[0].value.goal
            isCompleted = listCooking[indexPath.row].map{$0}[0].value.iscompleted
            break
        default:
            print("default")
            dataKey = 0
            text = "default"
            isCompleted = false
        }
        
        // cell index 값을 확인하기 위해서
        cell.datakeyIndex = dataKey
        cell.cellSection = indexPath.section
        cell.cellIndex = indexPath.row
        
        print("cell.datakeyIndex : \(cell.datakeyIndex)")
        print("cell.cellSection : \(cell.cellSection)")
        print("cell.cellIndex : \(cell.cellIndex)")
        
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
            
            DataManager.shared.delete(index: indexPath.row)
            
            tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = UIColor.red
        delete.title = "삭제"
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
