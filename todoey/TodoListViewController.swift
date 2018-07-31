//
//  ViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController,sendCategoryBack {
    
    

    var itemArray = ["First Item","Second Item","Third Item"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItmeCell",for:indexPath);
        cell.textLabel?.text = itemArray[indexPath.row];
        return cell
    }
   
    //Mark - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else
        {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
    }
    //Mark - Add Button Item
    @IBAction func addButtonItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addToDoCategory", sender: self)
    }
    //Mark - Get Category Back From Next Form
    func getCategory(category: String) {
        itemArray.append(category);
        self.tableView.reloadData();
    }
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToDoCategory"
        {
            let addCatVC = segue.destination as! AddCategoryViewController;
            addCatVC.delegate = self;
        }
    }
}

