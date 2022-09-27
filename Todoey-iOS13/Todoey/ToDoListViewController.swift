//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
   let itemArray = ["Book","Pen","Pencil"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
