//
//  ViewController.swift
//  GoodWeather
//
//  Created by Keshav Kishore on 25/06/22.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var  cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel:  UILabel!
    @IBOutlet weak var humidityLabel:  UILabel!
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit).asObservable().map { self.cityNameTextField.text}.subscribe(onNext: {city in
            if let city =  city {
                if city.isEmpty {
                    self.displayWeather(nil)
                } else {
                    self.fetchWeather(by: city)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPICity(city: cityEncoded) else {return}
        
        let resource = Resource<WeatherResult>(url: url)
        URLRequest.load(resource: resource).observeOn(MainScheduler.instance).catchAndReturn(WeatherResult.empty).subscribe(onNext: { result in
            let weather = result?.main
            self.displayWeather(weather)
        }).disposed(by: disposeBag)
    }
    
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℉"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "🙈"
            self.humidityLabel.text = "🚫"
        }
        
    }
    
}

