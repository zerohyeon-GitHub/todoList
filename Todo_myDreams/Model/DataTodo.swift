//
//  User.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/08.
//

import Foundation
import UIKit

enum TypeList: String, CaseIterable { // CaseIterable 과연 이건 뭘까??
    case Exercise = "Exercise"
    case Study = "Study"
    case Cooking = "Cooking"
}

struct DataTodo: Codable, Hashable { // 아카이빙, 언카이빙을 위해서 UserDefaults를 사용할 struct에 Codable 프로토콜 준수 ???
    // var id
    var type: String    // 타입
    var goal: String    // 목표
    var date: String    // 완료 일정
    var iscompleted: Bool  // 완료 여부
    var memo: String    // 추가 메모
}

class TodoList {
    // UserDefaults 데이터를 미리 선언하기 위해 - Type 별로 구분 (Dictionary 사용 - UserDefault의 index를 알기 위해서)
    static var listExercise: Array<Dictionary<Int, DataTodo>> = []
    static var listStudy: Array<Dictionary<Int, DataTodo>> = []
    static var listCooking: Array<Dictionary<Int, DataTodo>> = []
    
    static var listType: [String] = []
    
    // UserDefault 데이터 초기화
    func initData() {
        for i in 0..<DataManager.shared.load().count {
            switch DataManager.shared.load()[i].type {
            case TypeList.Exercise.rawValue:
                Self.listExercise.append([i : DataManager.shared.load()[i]])
            case TypeList.Study.rawValue:
                Self.listStudy.append([i : DataManager.shared.load()[i]])
            case TypeList.Cooking.rawValue:
                Self.listCooking.append([i : DataManager.shared.load()[i]])
            default:
                print("default")
            }
        }
        
        Self.listType = TypeList.allCases.map {
            $0.rawValue
        }
    }
    
    func appendProject(index: Int, todo: DataTodo) {
        switch todo.type {
        case TypeList.Exercise.rawValue:
            Self.listExercise.append([index : todo])
        case TypeList.Study.rawValue:
            Self.listStudy.append([index : todo])
        case TypeList.Cooking.rawValue:
            Self.listCooking.append([index : todo])
        default:
            print("default")
        }
    }
    
    func clear() {
        Self.listExercise = []
        Self.listStudy = []
        Self.listCooking = []
    }
}
