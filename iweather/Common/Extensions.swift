//
//  Extensions.swift
//  iweather
//
//  Created by Гриша on 26.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
