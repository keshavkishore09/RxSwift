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
    let behaviorRelay = BehaviorRelay<[Task]>(value: [])
    private var filteredTask = [Task]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController, let controller = navVC.viewControllers.first as? AddTaskViewController else {return}
        controller.taskObservable.subscribe(onNext: { [unowned self] task in
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            var exisitingTask = self.behaviorRelay.value
            exisitingTask.append(task)
            self.behaviorRelay.accept(exisitingTask)
            self.filterTask(by: priority)
        }).disposed(by: disposeBag)
    }
    
    
    @IBAction func selectedSegment(selectedSegment: UISegmentedControl){
        let priority = Priority(rawValue: selectedSegment.selectedSegmentIndex - 1)
        filterTask(by: priority)
    }
    
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTask(by priority: Priority?) {
        if priority == nil {
            self.filteredTask = self.behaviorRelay.value
            self.updateTableView()
        } else {
                self.behaviorRelay.map {tasks in
                return tasks.filter {$0.priority == priority!}
            }.subscribe(onNext:{ [weak self] tasks in
                self?.filteredTask = tasks
                self?.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
}



extension TaskListVieweController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTask.count
    }
}


extension TaskListVieweController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.filteredTask[indexPath.row].title
        return cell
        
    }
}
