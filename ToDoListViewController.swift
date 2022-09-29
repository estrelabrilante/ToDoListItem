//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
   var itemArray = ["Book","Pen","Pencil"]
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: dd item
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField();
    let alert = UIAlertController(title: "Add new item ", message: "Please add some items", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
    //what happens when the user clicks on add item button on our Alert
            self.itemArray.append(textField.text!)
            self.tableView.reloadData();
            }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    //MARK: TableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //allocates a table view cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //set the text of label in the textviewcell
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
//MARK: TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected an item")
        print(itemArray[indexPath.row])
        if let cellSelect = tableView.cellForRow(at: indexPath){
        if cellSelect.accessoryType == .checkmark{
            cellSelect.accessoryType = .none
        }
        else{
                cellSelect.accessoryType = .checkmark
        }
        }
       //change the background of the cell
    tableView.deselectRow(at: indexPath, animated: true)
//tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
     
}
