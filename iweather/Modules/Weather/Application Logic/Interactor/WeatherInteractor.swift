//
//  WeatherInteractor.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherInteractor: NSObject, WeatherInteractorInput, LocationServiceDelegate {
    
    var weatherPresenter: WeatherPresenter?
    var weatherService: WeatherService?
    var locationService: LocationService?
    
    
    //MARK: - LocationServiceDelegate
    
    func didUpdateLocation(location: CLLocation) {
        retrieveWeather(location, "local location")
    }
    
    //MARK: - WeatherInteractorInput
    
    func fetchWeather(_ location: Location) {
        let newLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        retrieveWeather(newLocation, location.name)
    }
    
    func fetchLocation() {
        locationService?.locationManager.requestWhenInUseAuthorization()
        locationService?.locationManager.requestLocation()
    }
    
    func retrieveWeather(_ location: CLLocation, _ locationName: String) {
        
        weatherService?.retrieveWeatherInfo(location, locationName) { (weather, error) in

            DispatchQueue.main.async(execute: {
                
                if let unwrappedError = error {
                    self.weatherPresenter?.didFetchWeather(unwrappedError)
                }
                
                guard let unwrappedWeather = weather else {
                    return
                }
                self.weatherPresenter?.didFetchWeather(unwrappedWeather)
                
            })
            
        }
        
    }
}
