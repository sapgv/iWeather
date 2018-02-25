//
//  WeatherModuleDelegate.swift
//  iweather
//
//  Created by Гриша on 21.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol WeatherModuleDelegate {
    
    func didFetchWeather(_ weather: Weather)
    func didFetchWeather(_ error: SWError)
    
}
