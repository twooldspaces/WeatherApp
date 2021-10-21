//
//  CurrentWeatherData.swift
//  weatherApp
//
//  Created by Artem on 02.10.2021.
//

import Foundation


// создаем структру api 
struct CurrentWeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp 
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
