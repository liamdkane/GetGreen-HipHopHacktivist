//
//  MapViewController.swift
//  GetGreen
//
//  Created by C4Q on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var greenMapView: MKMapView!
    @IBOutlet weak var greenSearchBar: UISearchBar!
    let locationManager: CLLocationManager = {
        let locMan: CLLocationManager = CLLocationManager()
        // more here later
        locMan.desiredAccuracy = 100.0
        locMan.distanceFilter = 50.0
        return locMan
    }()

    let geocoder: CLGeocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        greenMapView.delegate = self
        greenSearchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Oh woah, locations updated")
        //    dump(locations)
        
        guard let validLocation: CLLocation = locations.last else { return }
        
        // Display this with only 4 signification digits after the decimal
        // Hint: Use a specific string formatting initializer
        // Or: Do it the harder way with removing a range of string.
        
        // May the odds be ever in your favor. <mockingbird>
        //    self.latLabel.text = "Lat: \(validLocation.coordinate.latitude)"
        //    self.longLabel.text = "Long: \(validLocation.coordinate.longitude)"
        
        //mapView.setCenter(validLocation.coordinate, animated: true)
        
        //This will make the map zoom making the center the center of the map and the bounds the following parameters
        greenMapView.setRegion(MKCoordinateRegionMakeWithDistance(validLocation.coordinate, 500.0, 500.0), animated: true)
        
        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.title = "I FOUND WALDO!"
        pinAnnotation.coordinate = validLocation.coordinate
        greenMapView.addAnnotation(pinAnnotation)
        
        let circleOverlay: MKCircle = MKCircle(center: validLocation.coordinate, radius: 50.0)
        greenMapView.add(circleOverlay)
        
        geocoder.reverseGeocodeLocation(validLocation) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error != nil {
                dump(error!)
            }
            self.greenMapView.setCenter(validLocation.coordinate, animated: true)
            
            guard
                let validPlaceMarks: [CLPlacemark] = placemarks,
                let validPlace: CLPlacemark = validPlaceMarks.last
                else {
                    return
            }
            
            //self.geocodeLocationLabel.text = "\(validPlace.name!) \t \(validPlace.locality!)"
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
