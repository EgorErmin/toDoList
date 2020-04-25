//
//  ViewController.swift
//  toDoList
//
//  Created by Егор Ермин on 25.04.2020.
//  Copyright © 2020 Егор Ермин. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MainTableVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Task sorting type
    @IBOutlet weak var sortTypeSegmentControl: UISegmentedControl!
    
    // Table view for tasks display
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.delegate = self
        }
    }
    
    // Our model (list tasks)
    var groupTask: Results<Task>?
    // Point connect with RealmBD
    let realm = try! Realm()
    
    // MARK:- LifeCycle VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        groupTask = realm.objects(Task.self)
        tableView.reloadData()
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groupTask = groupTask else { return 0 }
        return groupTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasks = groupTask, let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {
            fatalError("No ProductCell")
        }
        let task = tasks[indexPath.row]
        cell.configureCell(name: task.name, date: task.createdAt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tasks = groupTask, let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "EditVC") as? EditVC else {
            return
        }
        vc.setTask(tasks[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- Navigation and Actions
    
    @IBAction func changeTypeSort(_ sender: Any) {
        switch sortTypeSegmentControl.selectedSegmentIndex {
        case 0:
            groupTask = groupTask?.sorted(byKeyPath: "name")
            tableView.reloadData()
        case 1:
            groupTask = groupTask?.sorted(byKeyPath: "createdAt")
            tableView.reloadData()
        default:
            return
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "AddTaskVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}

