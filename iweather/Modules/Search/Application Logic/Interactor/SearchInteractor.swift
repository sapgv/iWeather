//
//  SearchInteractor.swift
//  iweather
//
//  Created by Гриша on 24.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import Alamofire

class SearchInteractor: SearchInteractorInput {

    var searchDataManager: SearchDataManager?
    let url = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    let urlDetail = "https://maps.googleapis.com/maps/api/place/details/json"

    var searchPresenter: SearchPresenter?
    
    
    func fetchPlace(_ name: String) {
        
        let parameters: Parameters = [
            "input": name,
            "key": getAPIKEY(),
            "types": "(cities)"
        ]
        
        Alamofire.request(url, parameters: parameters).responseJSON {
            
            response in
            
            switch response.result {
            case .failure:
                self.searchPresenter?.didFetchPlaces([])
            case .success(let data):
                
                guard let json = data as? [String : AnyObject],
                    let predictions = json["predictions"] as? [[String: AnyObject]]
                    else {
                        print("cannot convert json")
                        return
                }
                
                
                let places = predictions.map { (prediction) -> placeTuples in
                    return (name: prediction["description"] as! String, place_id: prediction["place_id"] as! String)
                }
                
                self.searchPresenter?.didFetchPlaces(places)
                
            }
            
        }
        
    }
    
    func savePlace(_ place: placeTuples) {
        
        let parameters: Parameters = [
            "placeid": place.place_id,
            "key": getAPIKEY()
        ]
        
        Alamofire.request(urlDetail, parameters: parameters).responseJSON {
            
            response in
            
            switch response.result {
            case .failure:
                self.searchPresenter?.didFetchPlaces([])
            case .success(let data):
                
                guard let json = data as? [String : AnyObject],
                    let result = json["result"] as? [String: AnyObject],
                let geometry = result["geometry"] as? [String: AnyObject],
                let coordinates = geometry["location"] as? [String: AnyObject]
                    else {
                        print("cannot convert json")
                        return
                }
                
                let newLocation = Location(name: place.name, lat: coordinates["lat"] as! Double, lon: coordinates["lng"] as! Double)
                
                self.searchDataManager?.addNewLocation(newLocation)
                self.searchPresenter?.didSaveLocation(newLocation)
                                
            }
            
        }
    }
    
    func getAPIKEY() -> String {
        // get appId from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
        let key = parameters!["GoogleToken"]! as! String
        return key
    }
}



