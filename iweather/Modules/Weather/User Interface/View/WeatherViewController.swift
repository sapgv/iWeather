//
//  WeatherViewController.swift
//  iweather
//
//  Created by Гриша on 21.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewInterface, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    var forecastsHourly: [ForecastHourly]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var forecastsDaily: [ForecastDaily]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var eventHandler: WeatherModuleInterface?

    @IBOutlet var noContentView: UIView!
    @IBOutlet var strongView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCollectionView()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

        if (eventHandler?.location == nil) {
            view = noContentView
            return
        }
        view = strongView

    }

    
    @objc func didTapShowCities() {
        eventHandler?.presentCityInterface()
    }
    
    @objc func didTapUpdateWeather() {
        eventHandler?.fetchWeather()
    }
    
    @objc func updateWeather() {
        eventHandler?.fetchLocation()
    }
    
    //MARK - WeatherModuleInterface
    
    func clearView() {
        cleareWeatherView()
    }
    
    func fetchWeather() {
        eventHandler?.fetchWeather()
    }
    
    func updateViewForWeather(_ weather: Weather) {
        
        if let tempInt = Int(weather.temperature) {
            let fahrenheit = min(max(0, (tempInt*9)/5 + 32),99)
            let gradientImageName = "gradient\(Int(floor(Double(fahrenheit / 10)))).png"
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: gradientImageName)!)
        }
        
        self.locationLabel.text = weather.location
        self.tempLabel.text = weather.temperature
        self.iconLabel.text = weather.iconText
        self.descriptionLabel.text = weather.description
        
        self.windSpeedLabel.text = weather.windSpeed
        
        self.windImageView.image = UIImage(named: "direction")
        self.windImageView.transform = CGAffineTransform(rotationAngle: -(CGFloat(weather.windDirection) * CGFloat.pi)/180)
        
        self.pressureLabel.text = weather.pressure
        self.humidityLabel.text = weather.humidity
        
        forecastsHourly = weather.forecastsHourly
        forecastsDaily = weather.forecastsDaily
        
    }
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension WeatherViewController {
    
    func cleareWeatherView() {
        
        self.locationLabel.text = ""
        self.tempLabel.text = ""
        self.iconLabel.text = ""
        self.descriptionLabel.text = ""
        
        self.windSpeedLabel.text = ""
        self.windImageView.image = nil
        self.pressureLabel.text = ""
        self.humidityLabel.text = ""
        
        forecastsHourly = []
        forecastsDaily = []
    }
    
    //MARK: - Collection View
    
    func configureView() {
        
        navigationItem.title = "iWeather"
        
        let updateItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(WeatherViewController.didTapUpdateWeather))
        updateItem.tintColor = .white
        
        let cityItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(WeatherViewController.didTapShowCities))
        cityItem.tintColor = .white
        
        navigationItem.leftBarButtonItem = updateItem
        navigationItem.rightBarButtonItem = cityItem
    }
    
    func configureCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastsHourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as? ForecastCellHourly
        
        if let forecast = forecastsHourly?[indexPath.row] {
            cell?.forecastHourly = forecast
        }

        return cell!
        
    }
    
    //MARK: - Table View
    
    func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsDaily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                      for: indexPath) as? ForecastCellDaily
        
        if let forecast = forecastsDaily?[indexPath.row] {
            cell?.forecastDaily = forecast
        }
        
        return cell!
    }
}
