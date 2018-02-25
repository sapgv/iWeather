//
//  SearchWireframe.swift
//  iweather
//
//  Created by Гриша on 24.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

let SearchViewControllerIdentifier = "SearchViewController"

class SearchWireframe: NSObject {

    var searchPresenter: SearchPresenter? = nil
    var presentedViewController: UITableViewController?
    
    func presentSearchInterfaceFromViewController(_ viewController: UIViewController) {
        
        let newViewController = searchViewController()
        newViewController.eventHandler = searchPresenter
        
        searchPresenter?.viewController = newViewController
        
        let navigationController = UINavigationController(rootViewController: newViewController)
        viewController.present(navigationController, animated: true, completion: nil)
        
        presentedViewController = newViewController
        
    }
    
    func dismissSearchInterface() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func searchViewController() -> SearchViewController {
        let storyboard = mainStoryboard()
        let searchViewController: SearchViewController = storyboard.instantiateViewController(withIdentifier: SearchViewControllerIdentifier) as! SearchViewController
        return searchViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
