//
//  ViewController.swift
//  Location Aware
//
//  Created by MacBook Air on 11/10/17.
//  Copyright © 2017 MacBook Air. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var mapview = MapViewVC()
    
    var manager = CLLocationManager()
    
    @IBOutlet var latituteLbl: UILabel!
    
    @IBOutlet var longituteLbl: UILabel!
    
    @IBOutlet var course:UILabel!

    @IBOutlet var speedLbl: UILabel!
    
    @IBOutlet var altitudeLbl: UILabel!
    
    @IBOutlet var nearestAdLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let userlocation:CLLocation = locations[0]
        
        let latitude = userlocation.coordinate.latitude
        
        let lontitude = userlocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location1 = CLLocationCoordinate2D(latitude: latitude, longitude: lontitude)
      let region = MKCoordinateRegion(center: location1, span: span)
        
        mapview.mapView?.setRegion(region, animated: true)
        
        // user anotation 
        let annotation = MKPointAnnotation()
        
        annotation.title = ""
        annotation.subtitle = ""
        annotation.coordinate =  location1
        
        mapview.mapView?.addAnnotation(annotation)
        

        
        self.latituteLbl.text = String(location.coordinate.latitude)
        self.longituteLbl.text = String(location.coordinate.longitude)
        self.course.text = String(location.course)
        self.altitudeLbl.text = String(location.altitude)
        self.speedLbl.text = String(location.speed)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                print(error!)
            }else {
                if (placemarks?[0]) != nil {
                    
                   let placemark = placemarks?[0]
                    var adress = ""
                    
                    if placemark?.subThoroughfare != nil {
                        
                        adress += (placemark?.subThoroughfare)! + " "
                    }
                    if placemark?.thoroughfare != nil {
                        
                        adress += (placemark?.thoroughfare)! + "\n"
                    }
                    if placemark?.subLocality != nil {
                        
                        adress += (placemark?.subLocality)! + "\n"
                    }
                    if placemark?.subAdministrativeArea != nil {
                        
                        adress += (placemark?.subAdministrativeArea)! + "\n"
                    }
                    if placemark?.postalCode != nil {
                        
                        adress += (placemark?.postalCode)! + "\n"
                    }
                    if placemark?.country != nil {
                        
                        adress += (placemark?.country)! + "\n"
                    }
                   
                    
                    self.nearestAdLbl.text = adress

                    
                }
                
                
            
        }
        }
        
    }
    
    
    @IBAction func showMapView(_ sender: Any) {
        
      performSegue(withIdentifier: "showMap", sender: mapview.locationManager)
        
    }

    

}

