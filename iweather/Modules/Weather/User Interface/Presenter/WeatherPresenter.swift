//
//  WeatherPresenter.swift
//  iweather
//
//  Created by Гриша on 21.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

class WeatherPresenter: NSObject, WeatherModuleInterface, WeatherModuleDelegate {
    
    var location: Location?
    var weatherInteractor: WeatherInteractor?
    var weatherWireframe: WeatherWireframe?
    var userInterface: WeatherViewInterface?
    
    //MARK: - WeatherModuleInterface
    
    func presentCityInterface() {
        weatherWireframe?.presentCityInterface()
    }
    
    func fetchWeather() {
        
        guard let location = location else {
            //can also request location and after fetch weather
            return
        }
        weatherInteractor?.fetchWeather(location)
    }
    
    func fetchLocation() {
        weatherInteractor?.fetchLocation()
    }
    
    //MARK: - WeatherModuleDelegate
    
    func didFetchWeather(_ weather: Weather) {
        userInterface?.updateViewForWeather(weather)
    }
    
    func didFetchWeather(_ error: SWError) {
        
        switch error.errorCode {
        case .urlError:
            userInterface?.showError("The weather service is not working.")
        case .networkRequestFailed:
            userInterface?.showError("The network appears to be down.")
        case .jsonSerializationFailed:
            userInterface?.showError("We're having trouble processing weather data.")
        case .jsonParsingFailed:
            userInterface?.showError("We're having trouble parsing weather data.")
        }
        
    }
    
    
    
    
    
    
    
}
