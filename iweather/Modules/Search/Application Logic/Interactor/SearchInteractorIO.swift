//
//  SearchInteractorIO.swift
//  iweather
//
//  Created by Гриша on 27.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol SearchInteractorInput {
    
    func fetchPlace(_ name: String)
    func savePlace(_ place: placeTuples)
    
}

protocol SearchInteractorOutput {
    
    func didFetchPlaces(_ places: [placeTuples])
    func didSaveLocation(_ location: Location)
    
}
