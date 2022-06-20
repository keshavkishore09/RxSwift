//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Keshav Kishore on 20/06/22.
//

import UIKit


class AddTaskViewController: UIViewController {
    
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex), let title = self.taskTitleTextField.text else {return}
        let task  = Task(title: title, priority: priority)
    }
    
    
}
