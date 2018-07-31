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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,in:.userDomainMask).first?.appendingPathComponent("Items.plist")
    //let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad();
        loadItems();
       
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
        saveItems();
        tableView.reloadData();
    }
    //Mark - Add Button Item
    @IBAction func addButtonItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addToDoCategory", sender: self)
    }
    //Mark - Get Category Back From Next Form
    func getItem(newItem: Item) {
        itemArray.append(newItem);
        saveItems();
       
    }
    //MARK - Prepare for segue to add an item
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToDoCategory"
        {
            let addCatVC = segue.destination as! AddCategoryViewController;
            addCatVC.delegate = self;
        }
    }
    //Mark - Model Manipulation Methods
    func saveItems(){
        let encoder = PropertyListEncoder()
        do
        {
            let data = try encoder.encode(itemArray);
            try data.write(to: dataFilePath!);
        }
        catch
        {
            print("The error is \(error)");
        }
         tableView.reloadData();
    }
    func loadItems(){
       if let data = try? Data(contentsOf: dataFilePath!)
       {
        let decoder = PropertyListDecoder();
        do {
            itemArray = try decoder.decode([Item].self, from: data)
        }
        catch
        {
            print("error")
        }
        
       }
       
        
    }
}

