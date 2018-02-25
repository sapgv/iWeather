//
//  Weather.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct Weather {
    let location: String
    let iconText: String
    let temperature: String
    let dayTemperature: String
    let nightTemperature: String
    let description: String
    
    
    let windSpeed: String
    let pressure: String
    let humidity: String
    let windDirection: Int
    
    let forecastsHourly: [ForecastHourly]
    let forecastsDaily: [ForecastDaily]
}
