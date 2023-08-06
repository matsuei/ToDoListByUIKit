//
//  ToDoListDataSource.swift
//  ToDoListByUIKit
//
//  Created by Kenta Matsue on 2023/08/06.
//

struct ToDoListDataSource {
    var list: [ToDo] {
        return [
            ToDo(title: "ToDo1"),
            ToDo(title: "ToDo2"),
            ToDo(title: "ToDo3"),
            ToDo(title: "ToDo4"),
            ToDo(title: "ToDo5"),
        ]
    }
}

struct ToDo {
    let title: String
}
