//
//  CityPresenter.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

class CityPresenter: NSObject, CityInteractorOutput, CityModuleInterface, SearchModuleDelegate {
    
    var cityInteractor: CityInteractorInput?
    var cityWireframe: CityWireframe?
    var userInterface: CityViewInterface?
    
    //MARK - CityModuleInterface
    
    func configureUserInterfaceForPresentation(_ viewController: CityViewController) {
        
        
    }
    
    func showWeatherInLocation(_ location: Location) {
        cityWireframe?.presentWeatherInterface(location)
    }
    
    func dismiss() {
        cityWireframe?.dismissAddInterface()
    }
    func addNewCity() {
        cityWireframe?.presentAddInterface()
    }
    
    func updateView() {
        cityInteractor?.findLocations()
    }
    
    func deleteLocation(_ location: Location) {
        cityInteractor?.deleteLocation(location)
    }
    
    //MARK: - CityInteractorOutput
    
    func didFoundLocations(_ locations: [Location]) {
        userInterface?.showLocations(locations)
        
    }
    
    func didDeleteLocation() {
        userInterface?.reload()
    }
    
    //MARK - SearchModuleDelegate
    
    func searchModuleDidSaveLocation() {
        updateView()
    }
}
