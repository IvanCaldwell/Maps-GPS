//
//  ViewController.swift
//  Maps and GPS
//
//  Created by Ivan Caldwell on 12/15/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    // Variables and Constants
    let locationManager = CLLocationManager()
    
    // Outlets and Actions
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func saveButtonClicked(_ sender: Any) {
        let coord = locationManager.location?.coordinate
        if let lat = coord?.latitude {
            if let long = coord?.longitude {
                DataStore().StoredDataPoint(latitude: String(lat), longitude: String(long))
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // if the program needs to perform certain functions related to the location manager
        locationManager.delegate = self
        
        // Requesting authorization or permission to use obtain user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            // Need to create an alert that will inform the user that the app will
            // not work because the location is not enable. The print line will only
            // print a message in the console.
            print("Location not enable.")
            return
        }
        print("Location allowed.")
        // This is the programmically way of doing it. You can allow set this option
        // thru the GUI
        mapView.showsUserLocation = true
    }

}

