//
//  User.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/08.
//

import Foundation

class Todo {
    var goal: String
    var date: String
    var complete: Bool
    var memo: String
    
    init(goal: String, date: String, complete: Bool, memo: String) {
        self.goal = goal
        self.date = date
        self.complete = complete
        self.memo = memo
    }
}

class User {
    static var userTodo: [Todo] = []
    
    func appendTodo(todo: Todo) {
        Self.userTodo.append(todo)
    }
    
    func removeTodo(index: Int) {
        Self.userTodo.remove(at: index)
    }
    
    func emptyPoket() {
        Self.userTodo = []
    }
}
