//
//  URLRequest+Extension.swift
//  Good News
//
//  Created by Keshav Kishore on 23/06/22.
//

import Foundation
import RxCocoa
import RxSwift




struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url]).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map {  data -> T? in
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            print(json!)
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Error in decoding: \(error)")
                return nil
            }
        }.asObservable()
    }
    
    
}
