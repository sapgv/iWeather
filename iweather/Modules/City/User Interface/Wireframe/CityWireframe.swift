//
//  CityWireframe.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

let  CityViewControllerIdentifier = "CityViewController"

class CityWireframe: NSObject {

    var searchWireframe: SearchWireframe?
    var watherWireframe: WeatherWireframe?
    var cityPresenter: CityPresenter?
    var rootWireframe: RootWireframe?
    var cityViewController: CityViewController?
    
    func presentCityInterfaceFromWindow(_ window: UIWindow) {
        let viewController = cityViewControllerFromStoryboard()
        viewController.eventHandler = cityPresenter
        cityViewController = viewController
        cityPresenter?.userInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
        
    }
    
    func presentCityInterfaceFromController(_ viewController: WeatherViewController) {
        let newViewController = cityViewControllerFromStoryboard()
        newViewController.eventHandler = cityPresenter
        cityViewController = newViewController
        cityPresenter?.userInterface = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func dismissAddInterface() {
        cityViewController!.navigationController?.popViewController(animated: true)
    }
    
    func presentAddInterface() {
        searchWireframe?.presentSearchInterfaceFromViewController(cityViewController!)
    }
    
    func presentWeatherInterface(_ location: Location) {
        watherWireframe?.presentWeatherInteraceFromViewController(location, cityViewController!)
    }
    
    func cityViewControllerFromStoryboard() -> CityViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: CityViewControllerIdentifier) as! CityViewController
        return viewController
        
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
