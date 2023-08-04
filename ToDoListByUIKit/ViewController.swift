//
//  ViewController.swift
//  ToDoListByUIKit
//
//  Created by Kenta Matsue on 2023/08/04.
//

import UIKit

class ViewController: UIViewController {
    private weak var tableView: UITableView!
    
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
        // Do any additional setup after loading the view.
    }


}

