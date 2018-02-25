//
//  CityViewController.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

var CityCellIdentifier = "CityCell"

class CityViewController: UITableViewController, CityViewInterface {
    
    var eventHandler: CityModuleInterface?
    var locations: [Location]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventHandler?.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureView() {
        
        navigationItem.title = "Cities"
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CityViewController.didTapCancelButton))
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CityViewController.didTapAddButton))
        
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func didTapCancelButton() {
        eventHandler?.dismiss()
    }
    @objc func didTapAddButton() {
        eventHandler?.addNewCity()
    
    }
    
    // MARK: CitiesViewInterface
    
    func showLocations(_ locations: [Location]) {
        self.locations = locations
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let location = locations![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCellIdentifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = location.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let location = locations![indexPath.row]
        
        eventHandler?.showWeatherInLocation(location)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let location = locations![indexPath.row]
            eventHandler?.deleteLocation(location)
            
        }
    }
}
