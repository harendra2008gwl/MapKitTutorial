//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Harendra Sharma on 02/06/18.
//  Copyright © 2018 Harendra Sharma. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


// in case of CoreLocation only, not need to import MapKit
// in case of MapKit only, not need to import CoreLocation
// but in our case, we are using mapkit and coreLocation both so need to import both

// adding authorization keys in info.plist is very very important

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager() // CLLocationManager instance
    
    @IBOutlet weak var map: MKMapView! // create this IBOutlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        requestLocationAccess() // asking for authorizationStatus
       
        ConfigCoreLocationManager()
    }
    
    // Request for access location for mapkit and CLLocationManager
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
       
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // Configure core location manager notify delegates for location updates
    func ConfigCoreLocationManager() {
        if (CLLocationManager.locationServicesEnabled())
        {
            self.map.delegate = self
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    // MARK: CLLocationManager delegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        print("[locationManager] Location received: \(location)")
        
        
//    1.    //in case of mapkit core location triggers self/super class functions/delegates if location is not available
        
        // in case simulator we are providing default location to mapkit so MKMapView delegates will be triggered.
        
        // we can add our default gpx file for default locations
        
        
        // CLLocationManager will work simulator and device both but in case of indoor and simulator it not works properly so I recommoned you to use physical device to test CLLocationManager delegates/
        
        
        /// Stay tune with me, we will also learn mapkit advance with mvvm[model-view, view-mode], objects on map, custom overlays, cirles on map and lots of fun with mapkit and core location in advance series.
        
        
        
        
        
        // Thank you.
        // Please like and subscribe this and post your comment below.
        

    }
    
    
       // MARK: MKMapView delegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
          mapView .setCenter(userLocation.coordinate, animated: true)
          print("[mapView] Location received: \(userLocation.coordinate)")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

