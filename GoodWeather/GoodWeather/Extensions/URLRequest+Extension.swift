//
//  URLRequest+Extension.swift
//  GoodWeather
//
//  Created by Keshav Kishore on 25/06/22.
//

import UIKit
import RxCocoa
import RxSwift
import RxCocoa




struct Resource<T> {
    let url: URL
}


extension URLRequest {
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url]).flatMap { url -> Observable<Data> in
             let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> T? in
            do {
              return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Error in fetchong the data\(error)")
            return  nil
            }
        }.asObservable()
    }
}
 
