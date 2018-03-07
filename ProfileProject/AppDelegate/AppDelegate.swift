//
//  AppDelegate.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate , CLLocationManagerDelegate{
   
   var countryCode = ""
    var window: UIWindow?
    var locationManager: CLLocationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return true
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
           self.countryCode =  CodeManager.sharedInstance.getCountryCode(codeKey: (placeMark.isoCountryCode)!)
            print(self.countryCode)
            let codeDict:[String: String] = ["countryCode": self.countryCode]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countryCodeNotification"), object: nil, userInfo: codeDict)
           
        })
    }
    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    } 

}

