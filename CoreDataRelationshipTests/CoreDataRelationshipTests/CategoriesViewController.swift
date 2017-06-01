//
//  ViewController.swift
//  CoreDataRelationshipTests
//
//  Created by Paweł Liczmański on 02.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fetchResultController: NSFetchedResultsController<Category>!

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        
        let addCategoryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CategoriesViewController.addCategoryAlert))
            navigationItem.rightBarButtonItem = addCategoryButton
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }

    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = fetchResultController.object(at: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    func addCategoryAlert() {
        
        let addCategoryAlert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        
        
        
        addCategoryAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            
            guard let categoryNameToSave = addCategoryAlert.textFields?[0].text else {
                return
            }
            
            
            self.saveCategoryName(categoryName: categoryNameToSave)
        
            
            self.reloadData()
        }))
        
        addCategoryAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        addCategoryAlert.addTextField()
        addCategoryAlert.textFields?.first?.placeholder = "New Category Name"
        
        
        present(addCategoryAlert, animated: true, completion: nil)
        
    }
    
    func saveCategoryName(categoryName: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let category = Category(entity: Category.entity(), insertInto: managedContext)
        //category.setValue(categoryName, forKey: "name")
        category.name = categoryName
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save Category Failed \(error)")
        }
        
    }
    
    func reloadData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [nameSortDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: #keyPath(Category.name), cacheName: nil)
        
        do {
            try fetchResultController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            print("Fetch Result Controller Failed \(error)")
        }
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var indexOfSelectedCategory = indexPath
//        
//        
//    }
    
    


    
    
    
    
    
}


