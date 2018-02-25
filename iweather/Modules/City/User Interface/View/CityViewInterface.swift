//
//  CityViewInterface.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol CityViewInterface {
    func showLocations(_ locations: [Location])
    func reload()
}
