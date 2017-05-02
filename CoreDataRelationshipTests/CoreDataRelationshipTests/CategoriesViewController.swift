//
//  ViewController.swift
//  CoreDataRelationshipTests
//
//  Created by Paweł Liczmański on 02.05.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        
        let addCategoryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CategoriesViewController.goToAddCategoryScrean))
            navigationItem.rightBarButtonItem = addCategoryButton
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = "Test"
        
        return cell
    }
    
    func goToAddCategoryScrean() {
        
        let addCategoryAlert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        
        
        addCategoryAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        addCategoryAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        
        addCategoryAlert.addTextField()
        addCategoryAlert.textFields?.first?.placeholder = "New Category Name"
        
        
        present(addCategoryAlert, animated: true, completion: nil)
        
    }
    
    


    
    
    
    
    
}


