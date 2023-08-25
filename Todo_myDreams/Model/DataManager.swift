//
//  dataManager.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/25.
//

import Foundation

/*
 Singleton Pattern: 특정 용도로 객체를 하나만 생성하여, 공용으로 사용하고 싶을 때 사용하는 디자인 유형
 
 장점
 - 한 번의 Instance만 생성하므로 메모리 낭비를 방지할 수 있음
 - Singleton Instance는 전역 Instance로 다른 클래스들과 자원 공유가 쉬움
 - DBCP(DataBase Connection Pool)처럼 공통된 객체를 여러개 생성해서 사용해야하는 상황에서 많이 사용 (쓰레드풀, 캐시, 대화상자, 사용자 설정, 레지스트리 설정, 로그 기록 객체등)
 단점
 - Singleton Instance가 너무 많은 일을 하거나, 많은 데이터를 공유시킬 경우 다른 클래스의 Instance들 간 결합도가 높아져  "개방=폐쇄" 원칙을 위배함 (객체 지향 설계 원칙 어긋남)
 - 따라서 수정과 테스트가 어려워짐
 */

// Singelton Class
class DataManager {
    static let shared = DataManager() // static를 이용해 Instance를 저장할 프로퍼티를 하나 생성
    private let todoDataKey = "todoData"
    
    // JSONEncoder를 이용하여 객체를 아카이빙: 객체를 Memory, Disk에 저장할 수 있는 Data형으로 변환 후 변환된 Data형으로 UserDefaults에 저장
    func save(todo: [DataTodo]) { // 왜 구조체로 해야될까?
        
        var dataDB: [DataTodo] = []
        
        // UserDefaults에 파일이 있는지 확인.
        if !loadUsers().isEmpty {
            dataDB = loadUsers() // 있는 경우 해당 항목에 추가
        }
        
        // 받은 데이터 todo의 갯수를 파악
        for i in 0..<todo.count {
            dataDB.append(todo[i])
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataDB) { // encoded는 Data형
            UserDefaults.standard.set(encoded, forKey: todoDataKey)
        }
    }
    
    // JSONDecoder를 이용 언아카이빙하여 로드
    func loadUsers() -> [DataTodo] {
        let decoder = JSONDecoder()
        if let savedUsers = UserDefaults.standard.object(forKey: todoDataKey) as? Data {
            if let loadedUsers = try? decoder.decode([DataTodo].self, from: savedUsers) {
                return loadedUsers
            }
        }
        return []
    }
}
