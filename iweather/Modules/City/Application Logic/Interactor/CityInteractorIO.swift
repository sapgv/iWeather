//
//  ListIteractorIO.swift
//  iweather
//
//  Created by Гриша on 19.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol CityInteractorInput {
    func findLocations()
    func deleteLocation(_ location: Location)
}

protocol CityInteractorOutput {
    func didFoundLocations(_ locations: [Location])
    func didDeleteLocation()
}
