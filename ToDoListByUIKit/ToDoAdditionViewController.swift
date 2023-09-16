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
    private weak var titleTextField: UITextField!
    
    private var inputTitle: String?
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let button = UIButton()
        button.setTitle("追加", for: .normal)
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.placeholder = "タイトル"
        titleTextField.borderStyle = .roundedRect
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            titleTextField.widthAnchor.constraint(equalToConstant: 200),
            titleTextField.heightAnchor.constraint(equalToConstant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        self.view = view
        self.addToDoButton = button
        self.titleTextField = titleTextField
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addToDoButton.addAction(.init(handler: { [weak self] _ in
            guard let self, let inputTitle else {
                return
            }
            let todo = ToDo(title: inputTitle)
            dataSource.addToDo(todo)
            delegate?.toDoAdditionViewController(self, didAddToDo: todo)
        }), for: .primaryActionTriggered)
        addToDoButton.isEnabled = false
        titleTextField.addAction(.init(handler: { [weak self] _ in
            guard let self else {
                return
            }
            inputTitle = titleTextField.text
            addToDoButton.isEnabled = inputTitle != nil
        }), for: .editingChanged)
    }
}

extension ToDoAdditionViewController {
    static func make(dataSource: ToDoListDataSource) -> ToDoAdditionViewController {
        let viewController = ToDoAdditionViewController()
        viewController.dataSource = dataSource
        return viewController
    }
}
