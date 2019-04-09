//
//  ViewController.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/7/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var situationLabel: UILabel!
    @IBOutlet weak var weatherInCelsiusLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var nextDaysViewController: UICollectionView!
    
    @IBOutlet weak var nextDaysErrorMessage: UILabel!

    var isPermistionAlowed = false
    var dataSource: DataSourceCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todayCollectionView.register(UINib(nibName: "WeatherCell", bundle: .main), forCellWithReuseIdentifier: "WeatherCell")
        self.nextDaysViewController.register(UINib(nibName: "WeatherCell", bundle: .main), forCellWithReuseIdentifier: "WeatherCell")
        
        
        
        self.todayCollectionView.isHidden = true
        self.nextDaysViewController.isHidden = true
        
        LocationManager.shared.handleLocationAvailable = {
            self.getCityWeathe()
        }
        
        LocationManager.shared.handleAskLocationPermission = {
            let alert = UIAlertController(title: "Allow Location Access", message: "Weatherate needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)
            
            // Button to Open Settings
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }


    override func viewDidAppear(_ animated: Bool) {
        setupCollectionView()
        if LocationManager.shared.curentLocation != nil {
            self.getCityWeathe()
        }
    }
    

    func setupCollectionView() {
        let configureCell:(CollectionViewCellBlock) = {cell, item, edited in
            cell.configureCell(item: item)
        }
        dataSource = DataSourceCollectionView.init([], aCellIdentifier:CellIdentifierWeather, aConfigureCellBlock: configureCell)
        todayCollectionView.dataSource = dataSource
        todayCollectionView.delegate = dataSource

        self.nextDaysViewController.dataSource = dataSource
        self.nextDaysViewController.delegate = dataSource
    }
   
    private func loadData(collectionView: UICollectionView, data:[BaseViewModel]) {
        
        if(data.count > 0) {
            dataSource?.items.removeAllObjects()
        }
        dataSource?.items.addObjects(from: data)
        collectionView.reloadData()
        
    }
    
    func getCityWeathe() {
       
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WeatherRequestManager.shared.getWeatherByCityCoordinates((LocationManager.shared.curentLocation?.coordinate.latitude)!, (LocationManager.shared.curentLocation?.coordinate.longitude)!) { cityWeatherVM in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.humidityLabel.text = cityWeatherVM.humidity
                self.minTempLabel.text = cityWeatherVM.temp_min
                self.maxTempLabel.text = cityWeatherVM.temp_max
                self.weatherInCelsiusLabel.text = cityWeatherVM.temp
                self.pressureLabel.text = cityWeatherVM.pressure
                self.cityLabel.text = cityWeatherVM.name
                self.situationLabel.text = cityWeatherVM.weatherDescription
                self.getTodayWeather()
                self.getNextDaysWeather()
        }
    }
    
    func getTodayWeather() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WeatherRequestManager.shared.getForecast((LocationManager.shared.curentLocation?.coordinate.latitude)!, (LocationManager.shared.curentLocation?.coordinate.longitude)!) { weatherForecast in
                MBProgressHUD.hide(for: self.view, animated: true)
                //print("weatherForecast = \(weatherForecast)")
                self.todayCollectionView.isHidden = false
                self.loadData(collectionView: self.todayCollectionView, data: weatherForecast.forecastList)
            }
    }
    
    func getNextDaysWeather() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WeatherRequestManager.shared.getNextDaysForecast((LocationManager.shared.curentLocation?.coordinate.latitude)!, (LocationManager.shared.curentLocation?.coordinate.longitude)!) { weatherForecastNextDays, success in
                MBProgressHUD.hide(for: self.view, animated: true)
                if success {
                    self.nextDaysViewController.isHidden = false
                    self.nextDaysErrorMessage.isHidden = true
                    self.loadData(collectionView: self.nextDaysViewController, data: weatherForecastNextDays.forecastList)
                } else {
                    //print("fail")
                    self.nextDaysViewController.isHidden = true
                    self.nextDaysErrorMessage.isHidden = false
                }
        }
    }
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
}


extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        LocationManager.shared.curentLocation? = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        self.getCityWeathe()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
