//
//  ForecastDailyCell.swift
//  iweather
//
//  Created by Гриша on 25.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

class ForecastCellDaily: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var nightDayLabel: UILabel!
    
    var forecastDaily: ForecastDaily! {
        didSet {
            dateLabel.text = forecastDaily.date
            dayLabel.text = forecastDaily.dayOfWeek
            iconLabel.text = forecastDaily.iconText
            dayTempLabel.text = forecastDaily.dayTemperature
            nightDayLabel.text = forecastDaily.nightTemperature
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
