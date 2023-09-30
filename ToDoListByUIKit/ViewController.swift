//
//  ViewController.swift
//  ToDoListByUIKit
//
//  Created by Kenta Matsue on 2023/08/04.
//

import UIKit

class ViewController: UIViewController {
    private weak var tableView: UITableView!
    private let cellReuseIdentifier = "Cell"
    private let toDoListDataSource = ToDoListDataSource()
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        self.view = view
        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showToDoAdditionView))
        toolbarItems = [.flexibleSpace(), editButtonItem]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc func showToDoAdditionView() {
        let viewController = ToDoAdditionViewController.make(dataSource: toDoListDataSource)
        viewController.delegate = self
        present(viewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListDataSource.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let todo = toDoListDataSource.list[indexPath.row]
        content.text = todo.title
        content.image = todo.isComplete ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        toDoListDataSource.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoListDataSource.toggleIsComplete(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoListDataSource.delete(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension ViewController: ToDoAdditionViewControllerDelegate {
    func toDoAdditionViewController(_ viewController: ToDoAdditionViewController, didAddToDo todo: ToDo) {
        tableView.reloadData()
        dismiss(animated: true)
    }
}

