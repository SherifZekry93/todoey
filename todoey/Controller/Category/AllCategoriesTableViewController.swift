//
//  AllCategoriesTableViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
class AllCategoriesTableViewController: SwipeTableViewController,sendCategoriesBack {
   
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let categoryColor = [UIColor.red, UIColor.purple,UIColor.black,UIColor.blue,UIColor.brown,UIColor.white];
    override func viewDidLoad()
    {
        super.viewDidLoad();
        tableView.rowHeight = 80;
        loadCategories();
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let cat = categoryArray[indexPath.row]
        cell.textLabel?.text = cat.name;
        cell.textLabel?.textColor = UIColor.white
        if cat.catColor == 5
        {
            cell.textLabel?.textColor = UIColor.black;
        }
        cell.accessoryType = cat.done ? .checkmark : .none;
        let catColorID:Int = Int(cat.catColor)
        cell.backgroundColor = categoryColor[catColorID];
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count;
    }
    //MARK : tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CategoryTasks", sender: self)
    }
    //MARK: - Prepare for segue to add an item
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewCategory"
        {
            let addCatVC = segue.destination as! AddCategoryViewController;
            addCatVC.delegate = self;
        }
        if segue.identifier == "CategoryTasks"
        {
            let itemsVC = segue.destination as! TodoListViewController;
            if let indexPath = tableView.indexPathForSelectedRow
            {
                itemsVC.selectedCategory = categoryArray[indexPath.row]
            }
        }
    }
    //MARK - get Categories Back from the new form
    func getCategory(newCategory: Category)
    {
        categoryArray.append(newCategory);
        saveItems();
    }
    //MARK: Data Manipulation Methods
    func loadCategories(){
        let request : NSFetchRequest<Category> = Category.fetchRequest();
        do
        {
            categoryArray = try context.fetch(request);
        }
        catch
        {
            print("error fetching data\(error)")
        }
        tableView.reloadData();
    }
    //MARK: Save items to db
    func saveItems(reloadData:Bool = true){
        do
        {
            try context.save();
        }
        catch
        {
            print("error saving Context \(error)");
        }
        if reloadData == true
        {
            tableView.reloadData();
        }
    }
    //MARK: Delete data from a swipe
    override func updateModel(indexPath: IndexPath) {
         self.context.delete(self.categoryArray[indexPath.row])
         self.categoryArray.remove(at: indexPath.row);
         self.saveItems(reloadData: false);
    }
    
    override func markAsDone(indexPath: IndexPath) {
        
        categoryArray[indexPath.row].setValue(!categoryArray[indexPath.row].done, forKey:"done");
        saveItems();
        /*let request : NSFetchRequest<Item> = Item.fetchRequest();
        let predicate = NSPredicate(format: "parentCategory.name Matches %@", categoryArray[indexPath.row].name!)
        request.predicate = predicate;
        do
        {
            for item in categoryArray[indexPath.row]
            {
                
            }
        }
        catch
        {
            print("error fetching data\(error)")
        }
        tableView.reloadData();
        */
    }
    //MARK: Add Button Pressed
    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showCategoryTasks", sender: self)
    }
    
}
//MARK: Swipe Cell Delegate Method
//extension AllCategoriesTableViewController:SwipeTableViewCellDelegate
//{
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//            self.context.delete(self.categoryArray[indexPath.row])
//            self.categoryArray.remove(at: indexPath.row);
//            self.saveItems(reloadData: false);
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = .destructive
//        //options.transitionStyle = .border
//        return options
//    }
//
//}
