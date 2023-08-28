//
//  addListPopup.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class AddListPopup: UIViewController {
    let storyboardName = "Main" // 생성된 storyboard의 이름이 "Main"
    let storyboardID = "addTodo"
    
    var completion: (() -> Void)?
    
    @IBOutlet weak var typeStack: UIStackView!
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var dateStack: UIStackView!
    @IBOutlet weak var memoStack: UIStackView!
    
    @IBOutlet weak var pageName: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var todoType: UILabel!
    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var todoDate: UILabel!
    @IBOutlet weak var todoMemo: UILabel!
    
    @IBOutlet weak var tvType: UITextField!
    @IBOutlet weak var tvName: UITextField!
    @IBOutlet weak var tvDate: UITextField!
    @IBOutlet weak var tvMemo: UITextView!

    deinit{
        print("listview addpopup")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStackView()
        setTitle()
        setButton()
    }


    @IBAction func saveData(_ sender: Any) {
        // 현재 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: Date())
        
        let data: DataTodo = DataTodo(type: tvType.text ?? "", goal: tvName.text ?? "", date: tvName.text ?? currentDate, iscompleted: false, memo: tvName.text ?? "")
        
        DataManager.shared.save(todo: [data])
        
        print("userdefault count : \(DataManager.shared.load().count)")
        for i in 0..<DataManager.shared.load().count {
            print("\(i) : \(DataManager.shared.load()[i])")
        }

        completion?()
        self.dismiss(animated: true)
    }
    
    func setStackView(){
        typeStack.alignment = .fill
        typeStack.distribution = .fillProportionally
        typeStack.spacing = 10
        
        nameStack.alignment = .fill
        nameStack.distribution = .fillProportionally
        nameStack.spacing = 10
        
        dateStack.alignment = .fill
        dateStack.distribution = .fillProportionally
        dateStack.spacing = 10
        
        memoStack.spacing = 10
    }
    
    func setTitle(){
        pageName.text = "Todo 추가"
        pageName.font = UIFont.boldSystemFont(ofSize: 18)
        pageName.textColor = UIColor.black
        pageName.sizeToFit()
        pageName.textAlignment = .center
        
        todoType.text = "타입"
        todoType.font = UIFont.boldSystemFont(ofSize: 18)
        todoType.textColor = UIColor.black
        todoType.sizeToFit()
        todoType.textAlignment = .center
        
        todoName.text = "목표"
        todoName.font = UIFont.boldSystemFont(ofSize: 18)
        todoName.textColor = UIColor.black
        todoName.sizeToFit()
        todoName.textAlignment = .center
        
        todoDate.text = "완료일"
        todoDate.font = UIFont.boldSystemFont(ofSize: 18)
        todoDate.textColor = UIColor.black
        todoDate.sizeToFit()
        todoDate.textAlignment = .center
        
        todoMemo.text = "MEMO"
        todoMemo.font = UIFont.boldSystemFont(ofSize: 18)
        todoMemo.textColor = UIColor.black
    }
    
    func setButton(){
        saveBtn.setTitle("저장", for: .normal)
        saveBtn.contentHorizontalAlignment = .right
    }
}