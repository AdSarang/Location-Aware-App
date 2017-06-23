//
//  ViewController.swift
//  Location Aware
//
//  Created by Advait on 23/06/17.
//  Copyright © 2017 Advait. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var altitudeText: UILabel!
    @IBOutlet weak var speedText: UILabel!
    @IBOutlet weak var courseText: UILabel!
    @IBOutlet weak var longitudeText: UILabel!
    @IBOutlet weak var latitudeText: UILabel!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        latitudeText.text = String(userLocation.coordinate.latitude)
        
        longitudeText.text = String(userLocation.coordinate.longitude)
        
        courseText.text = String(userLocation.course)
        
        speedText.text = String(userLocation.speed)
        
        altitudeText.text = String(userLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation){(placemarks,error) in
            if error != nil {
                print(error!)
            }
            else{
                if let placemark = placemarks?[0]{
                    var subthoroughfare = " "
                    if placemark.subThoroughfare != nil{
                        subthoroughfare = placemark.subThoroughfare!
                    }
                    var thoroughfare = " "
                    if placemark.thoroughfare != nil{
                        thoroughfare = placemark.thoroughfare!
                    }
                    var sublocality = " "
                    if placemark.subLocality != nil{
                        sublocality = placemark.subLocality!
                    }
                    var subadministrativearea = " "
                    if placemark.subAdministrativeArea != nil{
                        subadministrativearea = placemark.subAdministrativeArea!
                    }
                    var postalcode = " "
                    if placemark.postalCode != nil{
                        postalcode = placemark.postalCode!
                    }
                    
                    self.addressText.text = String(subthoroughfare + " " + thoroughfare + "\n" + sublocality + "\n" + subadministrativearea + "\n" + postalcode)
                    
                    
                }
            }
            
        }
        

    }

}
