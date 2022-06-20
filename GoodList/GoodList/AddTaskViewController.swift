//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Keshav Kishore on 20/06/22.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    private let taskSubject = PublishSubject<Task>()
    
    var taskObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex), let title = self.taskTitleTextField.text else {return}
        let task  = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
