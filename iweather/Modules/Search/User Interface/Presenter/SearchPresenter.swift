//
//  SearchPresenter.swift
//  iweather
//
//  Created by Гриша on 24.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

class SearchPresenter: SearchModuleInterface, SearchInteractorOutput {
    
    var searchInteractor: SearchInteractorInput?
    var viewController: SearchViewInterface?
    var searchWireframe: SearchWireframe?
    var searchModuleDelegate: SearchModuleDelegate?
    
    //MARK: - SearchModuleInterface
    
    func searchPlace(_ name: String) {
        searchInteractor?.fetchPlace(name)
    }
    
    func cancelSearchAction() {
        searchWireframe?.dismissSearchInterface()
    }
    
    func savePlace(_ place: placeTuples) {
        searchInteractor?.savePlace(place)
    }
    
    //MARK: - SearchInteractorOutput
    
    func didFetchPlaces(_ places: [placeTuples]) {
        viewController?.places = places
    }
    
    func didSaveLocation(_ location: Location) {
        searchWireframe?.dismissSearchInterface()
        searchModuleDelegate?.searchModuleDidSaveLocation()
    }
    
}
