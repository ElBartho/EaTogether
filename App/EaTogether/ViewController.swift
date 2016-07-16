//
//  ViewController.swift
//  EaTogether
//
//  Created by EminE on 16/07/2016.
//  Copyright © 2016 EminE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBAction func SwitchedSegmented(sender: AnyObject) {
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            MapView.mapType = .Standard
        case 1:
            MapView.mapType = .Satellite
        default:
            MapView.mapType = .Standard
        }
    }
    
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.MapView.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARKS: location delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.MapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription, error.localizedFailureReason)
    }

}

