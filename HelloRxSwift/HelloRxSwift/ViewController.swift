//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Keshav Kishore on 08/06/22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Observable.from([1,2,3,4])
    }


}

