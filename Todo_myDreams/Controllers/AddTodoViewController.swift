//
//  AddTodoViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/01.
//

import UIKit

class AddTodoViewController: UIViewController {
    let storyboardName = "Main" // 생성된 storyboard의 이름이 "Main"
    let storyboardID = "addTodo"
    
    let typePicker = UIPickerView()
    // UIDatePicker 객체 생성을 해줍니다.
    let datePicker = UIDatePicker()
    
    var completion: (() -> Void)? // 클로저
    
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
        
        configPickerView()
        setupDatePicker()
        
        setNavigationoBar()
        
        setStackView()
        setTitle()
        setTextView()
    }
    
    
    
    
    // MARK: - Navigation Bar
    func setNavigationoBar() {
        self.navigationItem.title = "Todo List Add"
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: UIBarButtonItem.Style.plain, target: self, action: #selector(editDetailPage))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black

    }
    
    @objc private func editDetailPage(){
        // 현재 시간
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: Date())
        
        if tvType.text == "" {
            alertMessage(message: "타입")
        } else if tvName.text == "" {
            alertMessage(message: "목표")
        } else if tvName.text == "" {
            alertMessage(message: "완료일")
        } else if tvMemo.text == "" {
            alertMessage(message: "MEMO")
        } else {
            let data: DataTodo = DataTodo(type: tvType.text ?? "", goal: tvName.text ?? "", date: tvDate.text ?? currentDate, iscompleted: false, memo: tvMemo.text ?? "")
            
            DataManager.shared.save(todo: [data])

            print("saveData 완료")
            TodoList().appendProject(index: DataManager.shared.load().count-1, todo: data)
            
            completion?()
            navigationController?.popViewController(animated: true)
        }
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
        todoType.text = "타입을 선택해주세요!"
        todoType.font = UIFont.boldSystemFont(ofSize: 18)
        todoType.textColor = UIColor.black
        todoType.sizeToFit()
        todoType.textAlignment = .center
        
        todoName.text = "목표를 선정해주세요!"
        todoName.font = UIFont.boldSystemFont(ofSize: 18)
        todoName.textColor = UIColor.black
        todoName.sizeToFit()
        todoName.textAlignment = .center
        
        todoDate.text = "완료일을 설정해주세요!"
        todoDate.font = UIFont.boldSystemFont(ofSize: 18)
        todoDate.textColor = UIColor.black
        todoDate.sizeToFit()
        todoDate.textAlignment = .center
        
        todoMemo.text = "MEMO를 작성해주세요!"
        todoMemo.font = UIFont.boldSystemFont(ofSize: 18)
        todoMemo.textColor = UIColor.black
    }
    
    func setTextView(){
        tvMemo.layer.borderWidth = 0.25
        tvMemo.layer.borderColor = UIColor.lightGray.cgColor
        tvMemo.layer.cornerRadius = 5.0
    }
    
    // MARK: - Method & Action
    func alertMessage(message: String) {
        if true {
            let alert = UIAlertController(title: "할일 추가", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
}

extension AddTodoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // delegate, datasource 연결 및 picker를 textfied의 inputview로 설정한다
    func configPickerView() {
        typePicker.delegate = self
        typePicker.dataSource = self
        tvType.inputView = typePicker
        
        configToolbar()
    }
    // pickerview는 하나만
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // pickerview의 선택지는 데이터의 개수만큼
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TypeList.allCases.count
    }
    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var typeList: [String] = []
        TypeList.allCases.forEach{
            typeList.append($0.rawValue)
        }
        return typeList[row]
    }
    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var typeList: [String] = []
        
        TypeList.allCases.forEach{
            typeList.append($0.rawValue)
        }
        
        self.tvType.text = typeList[row]
    }
    
    func configToolbar() {
        // toolbar를 만들어준다.
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // 만들어줄 버튼
        // flexibleSpace는 취소~완료 간의 거리를 만들어준다.
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        // 만든 아이템들을 세팅해주고
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        // 악세사리로 추가한다.
        tvType.inputAccessoryView = toolBar
    }

    // "완료" 클릭 시 데이터를 textfield에 입력 후 입력창 내리기
    @objc func donePicker() {
        let row = self.typePicker.selectedRow(inComponent: 0)
        self.typePicker.selectRow(row, inComponent: 0, animated: false)
        var typeList: [String] = []
        
        TypeList.allCases.forEach{
            typeList.append($0.rawValue)
        }
        
        self.tvType.text = typeList[row]
        self.tvType.resignFirstResponder()
    }

    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.tvType.text = nil
        self.tvType.resignFirstResponder()
    }
    
    private func setupDatePicker() {
        // datePickerModed에는 time, date, dateAndTime, countDownTimer가 존재합니다.
        datePicker.datePickerMode = .date
        // datePicker 스타일을 설정합니다. wheels, inline, compact, automatic이 존재합니다.
        datePicker.preferredDatePickerStyle = .wheels
        // 원하는 언어로 지역 설정도 가능합니다.
        datePicker.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 동작을 설정해 줌
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        // textField의 inputView가 nil이라면 기본 할당은 키보드입니다.
        tvDate.inputView = datePicker
        // textField에 오늘 날짜로 표시되게 설정
        tvDate.text = dateFormat(date: Date())
        
        setupToolBar()
    }

    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
        tvDate.text = dateFormat(date: sender.date)
    }

    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
    
    private func setupToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))

        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()

        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시된다고 합니다.
        // 현재 inputView를 datePicker로 만들어 줬으니 datePicker위에 표시되겠죠?
        tvDate.inputAccessoryView = toolBar
    }

    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        
        tvDate.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        tvDate.resignFirstResponder()
    }
}

