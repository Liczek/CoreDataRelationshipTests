//
//  TasksViewController.swift
//  CoreDataRelationshipTests
//
//  Created by Paweł Liczmański on 04.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tasksTableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksTableViewController.delegate = self
        
    }
    
    
}

extension TasksViewController: UITableViewDelegate {
  
    
    
}

extension TasksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath)
        
        cell.textLabel?.text = "Testowy task"
        
        return cell
    }
    
    
}
