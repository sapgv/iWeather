//
//  City.swift
//  iweather
//
//  Created by Гриша on 19.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

struct Location {
    let name: String
    let lat: Double
    let lon: Double
    
    init(name: String, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
        let lat = dictionary["lat"] as? Double,
            let lon = dictionary["lon"] as? Double else {
                return nil
        }
        self.init(name: name, lat: lat, lon: lon)
    }
    var propertyList: [String : Any] {
        return ["name": name, "lat": lat, "lon": lon]
    }
}


