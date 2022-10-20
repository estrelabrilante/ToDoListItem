//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController{
    //let defaults = UserDefaults.standard;
    @IBOutlet weak var searchBar: UISearchBar!
    //var itemArray = ["Book","Pen","Pencil"]
    var itemArray = [Item]()
    //first item in the array
    //home directory : .userDomainMask
    // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //Using CoreData--AppDelegate: Coredata object
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //making IBOUTLET for UISearchBar and then setting outlet delegate as self
         searchBar.delegate = self
        
        // print(dataFilePath)
        // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        /*
         
         let newItem = Item()
         newItem.title = "pencil"
         itemArray.append(newItem)
         let newItem1 = Item()
         newItem1.title = "pen"
         itemArray.append(newItem1)
         let newItem2 = Item()
         newItem2.title = "eraser"
         itemArray.append(newItem2)
         */
        //retrieve data from UserDefaults
        /* if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
         itemArray = items
         }*/
        //retrieve data
        loadItem()
        
    }
    //MARK: - additem while pressing + button
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField();
        let alert = UIAlertController(title: "Add new item ", message: "Please add some items", preferredStyle: .alert);
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
            //what happens when the user clicks on add item button on our Alert
            //class: Item
            /*class Item: Codable{
             var title: String = ""
             var done: Bool = false
             }*/
            // let newItemText = Item()
            
            //context into permanaent storage inside our persistentContainer
            // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveData()
            //persist data using UserDefaults -- App crash for custom object
            // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        }
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    //MARK: - TableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //allocates a table view cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        //set the text of label in the textviewcell
        cell.textLabel?.text = item.title
        //Ternary operator
        //Value = condition: valueIftrue valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        /*if item.done == true{
         cell.accessoryType = .checkmark
         }
         else{
         cell.accessoryType = .none
         }*/
        
        return cell
    }
    //MARK: - TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DELETE from Container
        // context.delete(itemArray[indexPath.row])
        //DELETE from array
        //  itemArray.remove(at: indexPath.row)
        //UPDATE "done" property
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //*************************************
        /* if itemArray[indexPath.row].done == false{
         itemArray[indexPath.row].done = true
         }
         else{
         itemArray[indexPath.row].done = false
         }*/
        saveData()
        // tableView.reloadData()
        /* if let cellSelect = tableView.cellForRow(at: indexPath){
         if cellSelect.accessoryType == .checkmark{
         cellSelect.accessoryType = .none
         }
         else{
         cellSelect.accessoryType = .checkmark
         }
         }*/
        // ***************************************
        //change the background of the cell
        tableView.deselectRow(at: indexPath, animated: true)
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    //MARK: - Model Manipulation Methods -- coredata
    func saveData(){
        do{
            // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            try context.save()
            print("saved to database : Item")
        }
        catch{
            print("Error while saving context \(error)")
        }
        self.tableView.reloadData();
    }
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest()){
        
        
        do{
            itemArray = try context.fetch(request)
            print("Data read: \(itemArray)")
        }
        catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    //MARK: - Encoding data with NSEncoder
    /* func saveData(){
     //  let encoder = PropertyListEncoder()
     do{
     // let data = try encoder.encode(itemArray)
     // try data.write(to: dataFilePath!)
     }
     catch{
     print("Error encoding data \(error)")
     }
     self.tableView.reloadData();
     }*/
    /*func loadItem(){
     if let data = try? Data(contentsOf: dataFilePath!){
     let decoder = PropertyListDecoder()
     do{
     itemArray = try decoder.decode([Item].self, from: data)
     }
     catch{
     print("Error \(error)")
     }
     }
     }*/
}
    
//MARK: - UISearchBarDelegate delegate method
extension ToDoListViewController: UISearchBarDelegate{
    //querying data
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //new request
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        print("Searchbar Pressed",searchBar.text!)
        //NSPredicate specifies how data should be filtered or fetched
        
        request.predicate =  NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
         
        //fetch from persistent container
        loadItem(with: request)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
}
