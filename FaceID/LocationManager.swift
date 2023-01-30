//
//  LocationManager.swift
//  FaceID
//
//  Created by Adel Al-Aali on 1/30/23.
//

import Foundation
import CoreLocation


class LocationManager {
    func findLocation(){
        // 1. get user permissions
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // 2. report touser if permssion denied
        if authorizationStatus == .denied || authorizationStatus == .restricted {
            reportLocationServicesDeniedError()
            return
        }
        
        // 3. start / stop fidning location
        if isUpdatingLocation {
            stopLocationManager()
        }
        else { // end location services
            location = nil
            lastLocationError = nil
            startLocationManager()
            
        }
    }
    
    // inits location delegate, and location accuracy
    func startLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        
    }
    
    func stopLocationManager() {
        if isUpdatingLocation {
            locationManager.delegate = nil
            locationManager.stopUpdatingLocation()
            isUpdatingLocation = false
            
        }
    }
    
    
    
    func reportLocationServicesDeniedError() {
        let alert = UIAlertController(title: "try again.. ", message: "error" , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
    }
}
