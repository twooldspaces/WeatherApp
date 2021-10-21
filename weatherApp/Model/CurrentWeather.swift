//
//  CurrentWeather.swift
//  weatherApp
//
//  Created by Artem on 03.10.2021.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        // округляем и приводим к стринг
        return String(format: "%.1f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeString: String {
        // округляем и приводим к стринг
        return String(format: "%.1f", feelsLikeTemperature)
    }
    
    let conditionCode: Int// ид иконки
    var systemIconNameString: String {
        switch conditionCode {
        
        case 200...232: return "cloud.bolt.rain"
        case 300...321: return "clound.drizzle"
        case 500...531: return "clound.rain"
        case 600...622: return "clound.snow"
        case 701...781: return "smoke"
        case 800: return "sun.min"
        case 801...804: return "cloud"
        default: return "nosign"
        }
    }

    // init который может вернуть nil
    
    init? (currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
