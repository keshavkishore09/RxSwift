//
//  URL+Extension.swift
//  GoodWeather
//
//  Created by Keshav Kishore on 25/06/22.
//

import Foundation


extension URL {
    static func urlForWeatherAPICity(city: String) -> URL? {
        print("Url is: https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=060b776e4b6dfe694135e7901498bc58&units=imperial")
       return URL(string:  "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=060b776e4b6dfe694135e7901498bc58&units=imperial")
    }
}
