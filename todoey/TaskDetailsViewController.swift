//
//  TaskDetailsViewController.swift
//  todoey
//
//  Created by Sherif  Wagih on 8/1/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    var item:Item?
    let categoryColor = [UIColor.red, UIColor.purple,UIColor.black,UIColor.blue,UIColor.brown,UIColor.white];
    
    @IBOutlet weak var itemStatus: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var backGroundColor: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        taskTitle.text = item?.title;
        if item?.date == ""
        {
            taskDate.text = "No Date Specified"
        }
        else
        {
            taskDate.text = item?.date;
        }
        if item?.done == false
        {
            itemStatus.text = "In progress"
        }
        else
        {
            itemStatus.text = "Completed";
        }
        if item?.parentCategory?.catColor == 5
        {
            backGroundColor.textColor = UIColor.black;
        }
        let catColorID:Int = Int( (item?.parentCategory?.catColor)!)
       
        backGroundColor.backgroundColor = categoryColor[catColorID];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPress(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
