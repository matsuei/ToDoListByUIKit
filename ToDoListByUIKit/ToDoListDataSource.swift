//
//  ToDoListDataSource.swift
//  ToDoListByUIKit
//
//  Created by Kenta Matsue on 2023/08/06.
//

class ToDoListDataSource {
    private(set) var list = [ToDo]()
    
    func addToDo(_ todo: ToDo) {
        list.append(todo)
    }
}

struct ToDo {
    let title: String
}
