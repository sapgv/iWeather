//
//  CityInteractor.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

class CityInteractor: CityInteractorInput {
    
    var output: CityInteractorOutput?
    var dataManager: CityDataManager?
    
    func findLocations() {
        dataManager?.findLocations() {
            locations in
            self.output?.didFoundLocations(locations)
        }
    }
    
    func deleteLocation(_ location: Location) {
        dataManager?.deleteLocation(location)
        findLocations()
        
    }
    
}
