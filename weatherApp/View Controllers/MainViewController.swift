//
//  MainViewController.swift
//  weatherApp
//
//  Created by Artem on 02.10.2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    var networkWeatherManager = NetworkWeatherManager()
    
//    lazy var locationManager: CLLocationManager = {
//        let lm = CLLocationManager()
//        lm.delegate = self
//        lm.desiredAccuracy = kCLLocationAccuracyKilometer
//        lm.requestWhenInUseAuthorization()
//        return lm
//    }
    
    // MARK: - IBOUTLET
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    
    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onComletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateIntefaceWith(weather: currentWeather)
        }
        
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }
    
    // MARK: - ACTION
    @IBAction func searchPressed(_ sender: UIButton) {
        // вызываем alert
        presentSearchAlert(title: "Enter your city name", message: nil, style: .alert) { [unowned self]
            city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    
    // MARK: - UPDATE INTERFACE
    func updateIntefaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeString
            self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
    } 

}

// MARK: - LOCATION

extension MainViewController: CLLocationManagerDelegate {
    
}
