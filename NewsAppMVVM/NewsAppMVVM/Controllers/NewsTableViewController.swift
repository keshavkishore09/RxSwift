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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateViews()
    }
    
    
    
    private func populateViews() {
        
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apikey=1de78ab6990446e2a9a970ad484c5662")!)
        
        URLRequest.load(resource: resource).subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
    }
}

