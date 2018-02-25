//
//  RootWireframe.swift
//  iweather
//
//  Created by Гриша on 17.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe: NSObject {
    
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let navigationContoller = navigationControllerFromWindow(inWindow)
        navigationContoller.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }
    
}
