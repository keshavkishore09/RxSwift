//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by Keshav Kishore on 25/06/22.
//

import Foundation



struct WeatherResult: Decodable {
    let main: Weather
}

struct Weather: Decodable{
    let temp: Double
    let humidity: Double
    
    
}
