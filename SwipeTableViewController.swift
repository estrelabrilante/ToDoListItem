//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by user215496 on 10/23/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController ,SwipeTableViewCellDelegate{

override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - DATASOURCE METHOD
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell1.delegate = self
        
         return cell1
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }

    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        // handle action by updating model with deletion
        print("Delete cell")
        self.updateModel(at: indexPath)
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
    func updateModel(at indexPath: IndexPath){
        //update our data model
        print("Item deleted from superclass")
    }
}
