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
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        // запрос в пределах км
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        // запрос на доступ к геолокации
        lm.requestWhenInUseAuthorization()
        
        return lm
    }()
    
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
        
        // если настройка геолокации включена
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    // MARK: - ACTION
    @IBAction func searchPressed(_ sender: UIButton) {
        // вызываем alert
        presentSearchAlert(title: "Enter your city name", message: nil, style: .alert) { [unowned self]
            city in
            self.networkWeatherManager.fetchCurrentWeather(forRequsetType: .cityName(city: city))
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequsetType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
