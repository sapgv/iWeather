//
//  AppDependencies.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AppDependencies {
    
    var cityWireframe = CityWireframe()
    var weatherWireframe = WeatherWireframe()
    
    init() {
        ConfigureDependencies()
    }
    
    func installRootViewControllerFromWindow(_ window: UIWindow) {
        weatherWireframe.presentCityInterfaceFromWindow(window)
    }
    
    func ConfigureDependencies() {
        
        let coreDataStore = CoreDataStore()
        let rootWireframe = RootWireframe()
        
        let searchWireframe = SearchWireframe()
        let searchPresenter = SearchPresenter()
        let searchDataManager = SearchDataManager()
        searchDataManager.dataStore = coreDataStore
        searchWireframe.searchPresenter = searchPresenter
        
        let searchInteractor = SearchInteractor()
        searchPresenter.searchInteractor = searchInteractor
        searchPresenter.searchWireframe = searchWireframe
        searchInteractor.searchPresenter = searchPresenter
        searchInteractor.searchDataManager = searchDataManager
        
        
        
        let geoCoder = CLGeocoder()
        let locationService = LocationService()
        locationService.geoCoder = geoCoder
        
        let cityPresenter = CityPresenter()
        let cityDataManager = CityDataManager()
        let cityInteractor = CityInteractor()
        cityInteractor.dataManager = cityDataManager

        

        cityInteractor.output = cityPresenter
        
        cityPresenter.cityInteractor = cityInteractor
        cityPresenter.cityWireframe = cityWireframe
        
        cityWireframe.cityPresenter = cityPresenter
        cityWireframe.rootWireframe = rootWireframe
        cityWireframe.watherWireframe = weatherWireframe
        cityWireframe.searchWireframe = searchWireframe
        
        cityDataManager.coreDataStore = coreDataStore
        
        
        
        searchPresenter.searchModuleDelegate = cityPresenter
        
        
        let weatherInteractor = WeatherInteractor()

        
        let weatherService = WeatherService()
        
        locationService.delegate = weatherInteractor
        
        weatherInteractor.locationService = locationService
        weatherInteractor.weatherService = weatherService
        
        let weatherPresenter = WeatherPresenter()
        
        weatherInteractor.weatherPresenter = weatherPresenter
        weatherPresenter.weatherWireframe = weatherWireframe
        weatherPresenter.weatherInteractor = weatherInteractor
            
        weatherWireframe.weatherPresenter = weatherPresenter
        weatherWireframe.cityWireframe = cityWireframe
        weatherWireframe.rootWireframe = rootWireframe
    
    }
}
