//
//  WeatherViewInterface.swift
//  iweather
//
//  Created by Гриша on 21.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol WeatherViewInterface {
    
    func clearView()
    func fetchWeather()
    func updateViewForWeather(_ weather: Weather)
    func showError(_ message: String)
    
}
