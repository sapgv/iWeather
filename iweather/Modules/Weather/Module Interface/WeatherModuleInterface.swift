//
//  WeatherModuleInterface.swift
//  iweather
//
//  Created by Гриша on 21.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol WeatherModuleInterface {
    
    var location: Location? { get set }
    
    func presentCityInterface()
    func fetchWeather()
    func fetchLocation()
    
}
