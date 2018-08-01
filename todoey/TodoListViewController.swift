//
//  ViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: SwipeTableViewController,sendItemBack {
    
    var selectedCategory : Category?
    {
        didSet{
        loadItems()
        }
    }
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.rowHeight = 80;
       
    }
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title;
        cell.detailTextLabel?.text = item.date
        cell.accessoryType = item.done ? .checkmark : .none;
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            tableView.deselectRow(at: indexPath, animated: true);
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
            let addCatVC = segue.destination as! AddItemViewController;
            addCatVC.category = selectedCategory;
            addCatVC.delegate = self;
        }
    }
    //MARK: - Model Manipulation Methods
    func saveItems(reloadData:Bool = true){
        do
        {
            
            try context.save();
        }
        catch
        {
            print("error saving Context \(error)");
        }
        if reloadData
        {
        tableView.reloadData();
        }
    }
    //MARK: load All Items
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest();
        let predicate = NSPredicate(format: "parentCategory.name Matches %@", selectedCategory!.name!)
        request.predicate = predicate;
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
    //MARK: Delete an item
    override func updateModel(indexPath: IndexPath)
    {
        self.context.delete(self.itemArray[indexPath.row])
        self.itemArray.remove(at: indexPath.row);
        self.saveItems(reloadData: false);
    }
    override func markAsDone(indexPath: IndexPath) {
        itemArray[indexPath.row].setValue(!itemArray[indexPath.row].done, forKey:"done");
        saveItems();
    }
}
//MARK: Getting data from database
extension TodoListViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItems();
            DispatchQueue.main.async {
                self.resignFirstResponder();
            }
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
