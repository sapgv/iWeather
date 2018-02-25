//
//  LocationService.swift
//  iweather
//
//  Created by Гриша on 22.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func didUpdateLocation(location: CLLocation)
}

protocol LocationGeocodeDelegate {
    func didGeocodeName(_ name: String, _ location: CLLocation)
}
class LocationService: NSObject, CLLocationManagerDelegate {
    
    var delegate: LocationServiceDelegate?
    var managerDelegate: CLLocationManagerDelegate?
    var geocodeDelegate: LocationGeocodeDelegate?
    
    var geoCoder: CLGeocoder?
    
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyHundredMeters
        m.delegate = managerDelegate
        return m
    }()
    
    override init() {
        super.init()
        
    }
    
    func geocodeName(_ name: String) {
        
        geoCoder?.geocodeAddressString(name) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            // Use your location
            self.geocodeDelegate?.didGeocodeName(name, location)
        }}
    
    func startLocalService() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.delegate?.didUpdateLocation(location: location)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error obtain location \(error)")
    }
    
}
