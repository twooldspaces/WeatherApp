//
//  NetworkWeatherManager.swift
//  weatherApp
//
//  Created by Artem on 02.10.2021.
//

import Foundation

class NetworkWeatherManager {
    
    var onComletion: ((CurrentWeather) -> Void)?
    
    // создаем запрос api погоды
    func fetchCurrentWeather (forCity city: String ) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        
        
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
    
    // парсим json - раскладываем полученные данные по модели которую создали
    func parseJSON(withData data: Data) -> CurrentWeather? {
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
