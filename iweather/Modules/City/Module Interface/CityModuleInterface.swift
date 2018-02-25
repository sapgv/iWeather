//
//  CityModuleInterface.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol CityModuleInterface {
    func dismiss()
    func addNewCity()
    func updateView()
    func showWeatherInLocation(_ location: Location)
    func deleteLocation(_ location: Location)
}
