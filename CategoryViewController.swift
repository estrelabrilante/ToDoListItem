//
//  CategoryViewController.swift
//  Todoey
//
//  Created by user215496 on 10/20/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
//import SwipeCellKit

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // loadCategory()
        //load all category
        loadCategories()
        
    }
    //array of NSManaged Object : created using entity
    
    //var categoryArray = [Category]()
    //datatype: Results
    
    //communicate with persistent container-- COREDATA
    //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Nil Coalescing operator
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
       // cell1.delegate = self
        //comes from super class
        let cell1 = super.tableView(tableView, cellForRowAt: indexPath)
        cell1.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added"
        cell1.backgroundColor = UIColor(hexString: categoryArray?[indexPath.row].colourString ?? "1D98F6")
        return cell1
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new category ", message: "Please add some categories", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add category", style: .default){
            (action) in
            //new NSManaged object -- CoreData
            //  let newCategory = Category(context: self.context)
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colourString = UIColor.randomFlat().hexValue()
            self.save(category: newCategory)  //Write Realm
            
            //no need to append as it autoupdate in Realm
            //    self.categoryArray.append(newCategory)
            // self.saveCategory()
            
            
        }
        alert.addTextField{(field) in
            textField.placeholder = "create new category"
            textField = field
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    //MARK: - DATA MANIPULATING METHODS
    //Save Realm Database
    func save(category:Category){
        do{
            try realm.write
            {
                realm.add(category)
                
            }
            print("saved to database : Category")
        }
        catch{
            print("Error while saving context \(error)")
        }
        //tableView update with new data
        self.tableView.reloadData();
    }
    func loadCategories(){
        //pull all of Category OBject
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    //MARK: - Delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let categoryForDeletion = self.categoryArray?[indexPath.row]{
                do{
                    try self.realm.write{
                    self.realm.delete(categoryForDeletion)
                    }
                }
                catch{
                    print("Error while deleting row,\(error)")
                }
            }
        
    }
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
}
//MARK: - SWIPECELLKIT COCOAPODS
/*
 extension CategoryViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            if let categoryForDeletion = self.categoryArray?[indexPath.row]{
                do{
                    try self.realm.write{
                        self.realm.delete(categoryForDeletion)
                    }
                }
                catch{
                    print("Error while deleting row,\(error)")
                }
            }
        }
        
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon 1")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
}
 */
    
  //MARK: - COREDATA
  /*  func saveCategory(){
        do{
            commit context inside persistent container
            try context.save()
            }
            print("saved to database : Category")
        }
        catch{
            print("Error while saving context \(error)")
        }
        //tableView update with new data
        self.tableView.reloadData();
   
   }
   //read from context
func loadCategory(){
let request : NSFetchRequest<Category> = Category.fetchRequest()
       do{
           categoryArray = try context.fetch(request)
           print("Data read: \(categoryArray)")
       }
       catch{
           print("Error fetching data from context \(error)")
       }
       tableView.reloadData()
   }
   
 */
