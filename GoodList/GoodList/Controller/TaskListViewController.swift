//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Keshav Kishore on 20/06/22.
//

import UIKit
import RxSwift
import RxCocoa



class TaskListVieweController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    let behvaiorRelay = BehaviorRelay<[Task]>(value: [])
    private var filteredTask = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController, let controller = navVC.viewControllers.first as? AddTaskViewController else {return}
        controller.taskObservable.subscribe(onNext: { task in
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            var exisitingTask = self.behvaiorRelay.value
            exisitingTask.append(task)
            self.behvaiorRelay.accept(exisitingTask)
        }).disposed(by: disposeBag)
    }
    
    
    private func filterTask(by priority: Priority?) {
        if priority == nil {
            self.filteredTask = self.behvaiorRelay.value
        } else {
            self.behvaiorRelay.map { task  in
                return self.behvaiorRelay.filter { $0.priority  == priority}
            }.subscribe(onNext: { tasks in
                self.filteredTask = tasks
            })
        }
    }
}



extension TaskListVieweController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return behvaiorRelay.value.count
    }
}


extension TaskListVieweController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        return cell
    }
}
