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
    
    
    
    var fetchResultController: NSFetchedResultsController<Task>!
    
    @IBOutlet weak var tasksTableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksTableViewController.delegate = self
        
        
        let addTaskBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
        let cancelTaskButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        
        navigationItem.rightBarButtonItem = addTaskBarButton
        navigationItem.leftBarButtonItem = cancelTaskButton
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadDataAfterFetch()
        
    }
    
    func addTask() {
        
        let addTaskAlertController = UIAlertController(title: "Add New Task", message: nil, preferredStyle: .alert)
        addTaskAlertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            
            guard let taskNameToSave = addTaskAlertController.textFields?[0].text else {
                return
            }
            print(taskNameToSave)
            self.taskSave(taskName: taskNameToSave)
            self.reloadDataAfterFetch()
            
            
        }))
        addTaskAlertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        addTaskAlertController.addTextField(configurationHandler: nil)
        addTaskAlertController.textFields?[0].placeholder = "Add New Task Name"
        
        present(addTaskAlertController, animated: true, completion: nil)
        
        
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func taskSave(taskName: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =  appDelegate.persistentContainer.viewContext
        
        let category = Category(entity: Category.entity(), insertInto: managedContext)
        
        let tasks = category.mutableSetValue(forKey: "tasks")
        
        let task = Task(entity: Task.entity(), insertInto: managedContext)
        
        task.setValue(category, forKey: "category")
        
        task.name = taskName
        
        tasks.add(task)

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save Item Failed \(error)")
        }
    }
    
    func reloadDataAfterFetch() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSortDescriptor]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: #keyPath(Task.name), cacheName: nil)
        
        do {
            try fetchResultController.performFetch()
        } catch let error as NSError {
            print("Reload Data Failed (fetching) \(error)")
        }
        
        
        
        self.tasksTableViewController.reloadData()
    }
    
    
    
    
    
    
}

extension TasksViewController: UITableViewDelegate {
  
    
    
}

extension TasksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = fetchResultController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath)
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    
}
