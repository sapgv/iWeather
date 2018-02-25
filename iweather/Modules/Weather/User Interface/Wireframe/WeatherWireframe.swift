//
//  WeatherWireframe.swift
//  iweather
//
//  Created by Гриша on 21.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

let WeatherViewControllerIdentifier = "WeatherViewController"

class WeatherWireframe: NSObject {
    
    var weatherPresenter: WeatherPresenter?
    var cityWireframe: CityWireframe?
    var rootWireframe: RootWireframe?
    var weatherViewController: WeatherViewController?
    
    func presentCityInterfaceFromWindow(_ window: UIWindow) {
        let viewController = weatherViewControllerFromStoryboard()
        viewController.eventHandler = weatherPresenter
        weatherViewController = viewController
        if let propertyList = UserDefaults.standard.object(forKey: "Location") as? [String: Any] {
            weatherPresenter?.location = Location(dictionary: propertyList)
        }
        
        weatherViewController?.fetchWeather()
        weatherPresenter?.userInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
        
    }
    
    func presentCityInterface() {
        cityWireframe?.presentCityInterfaceFromController(weatherViewController!)
    }
    
    func presentWeatherInteraceFromViewController(_ location: Location, _ viewController: CityViewController) {
        UserDefaults.standard.set(location.propertyList, forKey: "Location")
        weatherPresenter?.location = location
        weatherViewController?.clearView()
        weatherViewController?.fetchWeather()
        viewController.navigationController?.popToViewController(weatherViewController!, animated: true)
    }
    
    func weatherViewControllerFromStoryboard() -> WeatherViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: WeatherViewControllerIdentifier) as! WeatherViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
