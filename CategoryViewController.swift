//
//  CategoryViewController.swift
//  Todoey
//
//  Created by user215496 on 10/20/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
}
   //array of NSManaged Object : created using entity
    
    var categoryArray = [Category]()
    //communicate with persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - TABLEVIEW DATASOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
       cell1.textLabel?.text = category.name
        return cell1
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new category ", message: "Please add some categories", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add category", style: .default){
            (action) in
            //new NSManaged object
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        alert.addTextField{(field) in
            textField.placeholder = "create new category"
            textField = field
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
        //MARK: - DATA MANIPULATING METHODS
        func saveCategory(){
            do{
                //commit context inside persistent container
                try context.save()
                print("saved to database : Category")
            }
            catch{
                print("Error while saving context \(error)")
            }
            //tableView update with new data
            self.tableView.reloadData();        }
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
        
        //MARK: - TABLEVIEW DELEGATE METHODS
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
        

}
