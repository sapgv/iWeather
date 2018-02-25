//
//  SearchModuleInterface.swift
//  iweather
//
//  Created by Гриша on 26.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation

protocol SearchModuleInterface {
    
    func searchPlace(_ name: String)
    func cancelSearchAction()
    func savePlace(_ place: placeTuples)
    
}
