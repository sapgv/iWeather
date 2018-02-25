//
//  SearchViewController.swift
//  iweather
//
//  Created by Гриша on 24.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

typealias placeTuples = (name: String, place_id: String)

class SearchViewController: UITableViewController, SearchViewInterface, UISearchBarDelegate {

    var eventHandler: SearchModuleInterface?
    var places: [placeTuples] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        eventHandler?.searchPlace(searchText)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        searchBar.resignFirstResponder()
        eventHandler?.cancelSearchAction()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = places[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        eventHandler?.savePlace(place)
    }
   

}
