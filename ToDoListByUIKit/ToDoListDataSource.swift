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
    
    func toggleIsComplete(_ index: Int) {
        guard 0...list.count-1 ~= index else {
            return
        }
        list[index].isComplete.toggle()
    }
    
    func delete(at index: Int) {
        guard 0...list.count-1 ~= index else {
            return
        }
        list.remove(at: index)
    }
}

struct ToDo {
    let title: String
    var isComplete = false
}
