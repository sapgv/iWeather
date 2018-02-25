//
//  WeatherInteractorIO.swift
//  iweather
//
//  Created by Гриша on 26.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherInteractorInput {
    
    func fetchWeather(_ location: Location)
    func fetchLocation()
    func retrieveWeather(_ location: CLLocation, _ locationName: String)
    
}

