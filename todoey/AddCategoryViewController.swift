//
//  AddCategoryViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
protocol sendCategoryBack {
    func getItem(newItem:Item);
}
class AddCategoryViewController: UIViewController {


    var delegate:sendCategoryBack?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //Mark : - Back Button Pressed
  
    @IBAction func backButtonPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //Mark : Item TextField Outlet
    @IBOutlet weak var newItemValue: UITextField!
    
    @IBAction func addCategoryButtonPressed(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let item =  Item(context: context);
        item.title = newItemValue.text!
        item.done = false;
        delegate?.getItem(newItem: item);
        self.dismiss(animated: true, completion: nil)
    }
}
