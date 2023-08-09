//
//  ToDoAdditionViewController.swift
//  ToDoListByUIKit
//
//  Created by Kenta Matsue on 2023/08/07.
//

import UIKit

protocol ToDoAdditionViewControllerDelegate: AnyObject {
    func toDoAdditionViewController(_ viewController: ToDoAdditionViewController,didAddToDo todo: ToDo)
}

class ToDoAdditionViewController: UIViewController {
    weak var delegate: ToDoAdditionViewControllerDelegate?
    private lazy var dataSource: ToDoListDataSource = { preconditionFailure() }()
    private weak var addToDoButton: UIButton!
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .systemBackground
        let button = UIButton()
        button.setTitle("追加", for: .normal)
        button.backgroundColor = .systemGray
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        self.view = view
        self.addToDoButton = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addToDoButton.addAction(.init(handler: { _ in
            let todo = ToDo(title: "ToDo-\(self.dataSource.list.count + 1)")
            self.dataSource.addToDo(todo)
            self.delegate?.toDoAdditionViewController(self, didAddToDo: todo)
        }), for: .primaryActionTriggered)
    }

}

extension ToDoAdditionViewController {
    static func make(dataSource: ToDoListDataSource) -> ToDoAdditionViewController {
        let viewController = ToDoAdditionViewController()
        viewController.dataSource = dataSource
        return viewController
    }
}
