//
//  AddDataManager.swift
//  iweather
//
//  Created by Гриша on 19.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreData

class SearchDataManager: NSObject {
    
    var dataStore: CoreDataStore!
    
    func addNewLocation(_ location: Location) {
        let newEntry = dataStore.newLocation()
        newEntry.name = location.name
        newEntry.lat = location.lat
        newEntry.lon = location.lon
        
        dataStore.save()
    }
}
