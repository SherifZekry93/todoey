//
//  AddCategoryViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
protocol sendCategoryBack {
    func getCategory(category:String);
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
        delegate?.getCategory(category: newItemValue.text!);
        self.dismiss(animated: true, completion: nil)
    }
}
