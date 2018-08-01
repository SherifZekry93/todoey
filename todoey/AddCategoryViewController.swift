//
//  AddCategoryViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 7/31/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

protocol sendCategoriesBack {
    func getCategory(newCategory:Category);
}

class AddCategoryViewController: UIViewController {
    
    var delegate:sendCategoriesBack?
    var catColor:Int = 5;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: outlets
    
    @IBAction func buttonColorPressed(_ sender: UIButton)
    {
        catColor =  sender.tag;        
    }
    @IBOutlet weak var textCategoryValue: UITextField!
    
    @IBAction func addCategoryButtonPress(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let category =  Category(context: context);
        category.name = textCategoryValue.text!
        category.catColor = Int16(catColor);
        delegate?.getCategory(newCategory: category)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
