//
//  WeatherBuilder.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct WeatherBuilder {
    var location: String?
    var iconText: String?
    var temperature: String?
    var dayTemperature: String?
    var nightTemperature: String?
    var description: String?
    
    var windSpeed: String?
    var pressure: String?
    var humidity: String?
    var windDirection: Int?
    
    var forecastsHourly: [ForecastHourly]?
    var forecastsDaily: [ForecastDaily]?
    
    func build() -> Weather {
        return Weather(location: location!,
                       iconText: iconText!,
                       temperature: temperature!,
                       dayTemperature: dayTemperature!,
                       nightTemperature: nightTemperature!,
                       description: description!,
                       
                       windSpeed: windSpeed!,
                       pressure: pressure!,
                       humidity: humidity!,
                       windDirection: windDirection!,
                       
                       forecastsHourly: forecastsHourly!,
                       forecastsDaily: forecastsDaily!)
    }
}
