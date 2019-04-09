//
//  LocationManager.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/9/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var curentLocation: CLLocation?
    var isLocationAvailabel = false
    static let shared = LocationManager()
    
    var handleLocationAvailable: (() -> ())?
    var handleAskLocationPermission: (() -> ())?
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.curentLocation = location
        if !isLocationAvailabel {
            isLocationAvailabel = true
            self.handleLocationAvailable!()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print(state)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        switch status {
        case .denied:
            self.handleAskLocationPermission!()
        default:
            break
        }
    }
}
