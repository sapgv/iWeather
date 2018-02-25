//
//  iweatherTests.swift
//  iweatherTests
//
//  Created by Гриша on 27.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import XCTest
import CoreLocation
@testable import iweather

class iweatherDataTests: XCTestCase {
    
    var location: Location!
    var coreDataStore: CoreDataStore = CoreDataStore()
    var cityDataManager: CityDataManager = CityDataManager()
    var searchDataManager: SearchDataManager = SearchDataManager()
    var weatherService: WeatherService = WeatherService()
    
    override func setUp() {
        super.setUp()
        
        cityDataManager.coreDataStore = coreDataStore
        searchDataManager.dataStore = coreDataStore
        // Put setup code here. This method is called before the invocation of each test method in the class.
        location = Location(name: "London", lat: 51.509865, lon: -0.118092)
    }
    
    override func tearDown() {
        super.tearDown()
        
        cityDataManager.deleteLocation(location)
    }
    func testFindLocations() {
        self.measure() {
            
            self.cityDataManager.findLocations() {
                locations in
            }
        }
    }
    
    func testFetchWeather() {
        
        let coreLocation = CLLocation(latitude: location.lat, longitude: location.lon)
        self.measure {
            weatherService.retrieveWeatherInfo(coreLocation, location.name) { (weather, error) in
                
            }
            
        }
    }
    
    func testNewLocation() {

        searchDataManager.addNewLocation(location)
        
        let locationEntity = searchDataManager.dataStore.fetchLocation(location.name)
        
        XCTAssertEqual(location.name, locationEntity?.name, "name not equal")
        XCTAssertEqual(location.lat, locationEntity?.lat, "latitude not equal")
        XCTAssertEqual(location.lon, locationEntity?.lon, "londitide not equal")
        
    }
    
}
