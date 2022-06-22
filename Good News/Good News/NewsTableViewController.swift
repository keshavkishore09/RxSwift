//
//  NewsTableViewController.swift
//  Good News
//
//  Created by Keshav Kishore on 22/06/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {fatalError("Cell fails to be created")}
        cell.titleLabel.text = self.articles[indexPath.row].title
        cell.descriptionLabel.text = self.articles[indexPath.row].description
        return cell

    }
    
    
    
    private func populateNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apikey=1de78ab6990446e2a9a970ad484c5662")!
        Observable.just(url).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> [Article]? in
            return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
        }.subscribe(onNext: { [weak self] articles in
            if let articles = articles {
                print(articles)
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }).disposed(by: disposeBag)
    }
    
    
}
