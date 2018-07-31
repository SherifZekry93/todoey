//
//  ViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController,sendCategoryBack {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad();
        loadItems()
    }
    //MARK: - Tableview Datasource Methods
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
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done;
        saveItems();
        
    }
    //MARK: - Add Button Item
    @IBAction func addButtonItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addToDoCategory", sender: self)
    }
    //MARK:- Get Category Back From Next Form
    func getItem(newItem: Item) {
        //    print("the new item " )
        //print(newItem);
        itemArray.append(newItem);
        saveItems();
    }
    //MARK: - Prepare for segue to add an item
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToDoCategory"
        {
            let addCatVC = segue.destination as! AddCategoryViewController;
            addCatVC.delegate = self;
        }
    }
    //MARK: - Model Manipulation Methods
    func saveItems(){
        do
        {
            
            try context.save();
        }
        catch
        {
            print("error saving Context \(error)");
        }
        tableView.reloadData();
    }
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest();
        do
        {
            itemArray = try context.fetch(request);
        }
        catch
        {
          print("error fetching data\(error)")
        }
         tableView.reloadData();
    }
}
//MARK: Getting data from database
extension TodoListViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItems();
            resignFirstResponder();
           // view.layoutIfNeeded()
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format:"title CONTAINS %@",searchBar.text!);
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do
        {
            itemArray = try context.fetch(request);
        }
        catch
        {
            print("error fetching data\(error)")
        }
        tableView.reloadData();
    }
}
