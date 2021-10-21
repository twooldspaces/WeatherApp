//
//  NetworkWeatherManager.swift
//  weatherApp
//
//  Created by Artem on 02.10.2021.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequsetType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onComletion: ((CurrentWeather) -> Void)?
    
    
    func fetchCurrentWeather(forRequsetType requsetType: RequsetType) {
        var urlString = ""
        switch requsetType {
        
        case .cityName(let city):
           urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
            
        case .coordinate(let latitude,let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
            
            
    }
        performRequset(withURLString: urlString)
    }
//
//    func fetchCurrentWeather (forCity city: String ) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
//
//        performRequset(withURLString: urlString)
//    }
//
//    func fetchCurrentWeather (forLatitude latitude: CLLocationDegrees, longitude: CLLocationDegrees ) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon= \(longitude)&appid=\(apiKey)&units=metric"
//
//        performRequset(withURLString: urlString)
//    }
    
    fileprivate func performRequset(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if  let currentWeather = self.parseJSON(withData: data) {
                    self.onComletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            print(currentWeatherData.main.temp)
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
