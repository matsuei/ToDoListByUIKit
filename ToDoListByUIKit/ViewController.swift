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
        tableView.backgroundColor = .systemBlue
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListDataSource.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = toDoListDataSource.list[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

