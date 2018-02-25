//
//  Temperature.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct Temperature {
    
    let degrees: String
    
    init(_ openWeatherMapDegrees: Double) {
        
        //let's use only celsius temperature
        degrees = String(Converter.kelvinToCelsius(openWeatherMapDegrees))
        
        
    }
}
