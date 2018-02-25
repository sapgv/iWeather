//
//  CollectionCell.swift
//  iweather
//
//  Created by Гриша on 16.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

class ForecastCellHourly: UICollectionViewCell {
  
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var forecastHourly: ForecastHourly! {
        didSet {
            timeLabel.text = forecastHourly.time
            iconLabel.text = forecastHourly.iconText
            dateLabel.text = forecastHourly.newDay ? forecastHourly?.date : ""
            tempLabel.text = forecastHourly.temperature
        }
    }
    
    override func awakeFromNib() {
        backView.layer.cornerRadius = 5;
        backView.layer.masksToBounds = true;
    }
    
}
