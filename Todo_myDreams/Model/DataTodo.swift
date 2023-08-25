//
//  User.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/08.
//

import Foundation
import UIKit

struct DataTodo: Codable { // 아카이빙, 언카이빙을 위해서 UserDefaults를 사용할 struct에 Codable 프로토콜 준수 ???
    var type: String    // 타입
    var goal: String    // 목표
    var date: String    // 완료 일정
    var iscompleted: Bool  // 완료 여부
    var memo: String    // 추가 메모
}
