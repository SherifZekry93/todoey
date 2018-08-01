//
//  SwipeTavleTableViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import SwipeCellKit
class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath) as! SwipeTableViewCell;
        cell.delegate = self;
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(indexPath: indexPath)
            // handle action by updating model with deletion
        
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        let flag = SwipeAction(style: .destructive, title: "Flag") {
            action, index in
          self.markAsDone(indexPath: indexPath);
        }
        flag.backgroundColor = UIColor.orange
        
        return [deleteAction,flag]
    }
    func markAsDone(indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
    func updateModel(indexPath: IndexPath)
    {
        
    }

}
