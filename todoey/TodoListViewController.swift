//
//  ViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController,sendCategoryBack {
    
    

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Item();
        item.title = "Save the world";
       // item.done = true;
        let item2 = Item();
        
        item2.title = "Save the Univers";
       // item2.done = true;
        let item3 = Item();
        item3.title = "Save Someone";
        item3.done = true;
        itemArray.append(item);
        
        itemArray.append(item2);
        
        itemArray.append(item3);
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
//        {
//            itemArray = defaults.array(forKey: "ToDoListArray") as! [String];
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItmeCell",for:indexPath);
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title;
        cell.accessoryType = item.done ? .checkmark : .none;
        
        return cell
    }
   
    //Mark - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done;
        
        tableView.reloadData();
    }
    //Mark - Add Button Item
    @IBAction func addButtonItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addToDoCategory", sender: self)
    }
    //Mark - Get Category Back From Next Form
    func getItem(newItem: Item) {
        itemArray.append(newItem);
        //self.defaults.set(self.itemArray, forKey:"ToDoListArray");
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

