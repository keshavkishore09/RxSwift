//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Keshav Kishore on 26/06/22.
//

import UIKit
import RxSwift


class NewsTableVieController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var articleListViewModel: ArticleListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateViews()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel == nil ? 0: self.articleListViewModel.articleVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {fatalError("Cell not found")}
        let articleViewModel = self.articleListViewModel.article(indexPath.row)
        articleViewModel.title.asDriver(onErrorJustReturn: "").drive(cell.titleLabel.rx.text)
        articleViewModel.description.asDriver(onErrorJustReturn: "").drive(cell.descriptionLabel.rx.text)
        
        return cell
    }
    
    
    private func populateViews() {
        
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apikey=1de78ab6990446e2a9a970ad484c5662")!)
        
        URLRequest.load(resource: resource).subscribe(onNext: { response in
            let articles = response.articles
            self.articleListViewModel  = ArticleListViewModel(articles)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        
    }
}

